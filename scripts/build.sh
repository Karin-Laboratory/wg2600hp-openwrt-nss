#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
OPENWRT_DIR=${OPENWRT_DIR:-}
NSS_FIRMWARE_DIR=${NSS_FIRMWARE_DIR:-}
BUILD_LOG=${BUILD_LOG:-"$ROOT/build-state-$(date -u +%Y%m%dT%H%M%SZ).log"}
OPENWRT_COMMIT=f0a60eee2fe051741c643ea6118718aae1ef17fb

die() { echo "build.sh: $*" >&2; exit 2; }
need_cmd() { command -v "$1" >/dev/null 2>&1 || die "required command not found: $1"; }
need_cmd git
need_cmd make
need_cmd sha256sum
need_cmd unsquashfs

[ -n "$OPENWRT_DIR" ] || die "set OPENWRT_DIR to a clean OpenWrt checkout"
[ -d "$OPENWRT_DIR/.git" ] || die "OPENWRT_DIR is not a Git checkout: $OPENWRT_DIR"
[ -f "$OPENWRT_DIR/include/version.mk" ] || die "OPENWRT_DIR is not an OpenWrt source tree"
[ -n "$NSS_FIRMWARE_DIR" ] || die "set NSS_FIRMWARE_DIR; firmware blobs are not redistributed"
actual_commit=$(git -C "$OPENWRT_DIR" rev-parse HEAD) || die "cannot read OpenWrt HEAD"
[ "$actual_commit" = "$OPENWRT_COMMIT" ] || die "OpenWrt HEAD is $actual_commit, expected $OPENWRT_COMMIT (v25.12.5)"
[ ! -e "$OPENWRT_DIR/.config" ] || die "refusing an existing .config; use a fresh checkout"
[ ! -d "$OPENWRT_DIR/build_dir" ] || die "refusing existing build_dir; use a fresh checkout"
[ ! -d "$OPENWRT_DIR/staging_dir" ] || die "refusing existing staging_dir; use a fresh checkout"
[ ! -d "$OPENWRT_DIR/tmp" ] || die "refusing existing tmp; use a fresh checkout"

for name in qca-nss0-retail.bin qca-nss1-retail.bin; do
    [ -f "$NSS_FIRMWARE_DIR/$name" ] || die "missing firmware: $NSS_FIRMWARE_DIR/$name"
done
verify_blob() {
    name=$1 expected_size=$2 expected_sha=$3
    path=$NSS_FIRMWARE_DIR/$name
    size=$(wc -c < "$path" | tr -d ' ')
    sha=$(sha256sum "$path" | awk '{print $1}')
    [ "$size" = "$expected_size" ] || die "$name size $size != expected $expected_size"
    [ "$sha" = "$expected_sha" ] || die "$name SHA256 $sha != expected $expected_sha"
    echo "firmware $name size=$size sha256=$sha"
}
verify_blob qca-nss0-retail.bin 544712 265d0a87b527f7c6c441af166bcc8a762ee23bfdc515585de29034f214cd481d
verify_blob qca-nss1-retail.bin 218860 b09c5646550f9e7fbd916daf6f6a7975b66fdfd1faf0960b1e624b4708008b79

mkdir -p "$OPENWRT_DIR/package/kernel" "$OPENWRT_DIR/target/linux/ipq806x/patches-6.12"
for pkg in qca-nss-gmac qca-nss-drv qca-nss-ecm; do
    rm -rf "$OPENWRT_DIR/package/kernel/$pkg"
    mkdir -p "$OPENWRT_DIR/package/kernel/$pkg/patches"
    cp -a "$ROOT/packages/$pkg/." "$OPENWRT_DIR/package/kernel/$pkg/"
    cp -a "$ROOT/patches/$pkg/." "$OPENWRT_DIR/package/kernel/$pkg/patches/"
done
cp -a "$ROOT/patches/openwrt-ipq806x/." "$OPENWRT_DIR/target/linux/ipq806x/patches-6.12/"
cp "$NSS_FIRMWARE_DIR/qca-nss0-retail.bin" "$OPENWRT_DIR/package/kernel/qca-nss-drv/files/nss-firmware/"
cp "$NSS_FIRMWARE_DIR/qca-nss1-retail.bin" "$OPENWRT_DIR/package/kernel/qca-nss-drv/files/nss-firmware/"

{
    echo "UTC=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "ROOT=$ROOT"
    echo "OPENWRT_DIR=$OPENWRT_DIR"
    echo "OPENWRT_COMMIT=$actual_commit"
    git -C "$OPENWRT_DIR" status --short
    git -C "$OPENWRT_DIR" describe --always --dirty
    sha256sum "$ROOT/config/wg2600hp.config.fragment" "$ROOT/patches/openwrt-ipq806x/999-005-wg2600hp-nss-minimal-6.12.patch"
} > "$BUILD_LOG"

cd "$OPENWRT_DIR"
echo "feeds: update -a" | tee -a "$BUILD_LOG"
./scripts/feeds update -a 2>&1 | tee -a "$BUILD_LOG"
./scripts/feeds install -a 2>&1 | tee -a "$BUILD_LOG"
cp "$ROOT/config/wg2600hp.config.fragment" .config
make defconfig 2>&1 | tee -a "$BUILD_LOG"
./scripts/diffconfig.sh 2>&1 | tee -a "$BUILD_LOG"
make -j1 V=s 2>&1 | tee -a "$BUILD_LOG"

target_dir=bin/targets/ipq806x/generic
manifest=$(find "$target_dir" -maxdepth 1 -type f -name '*manifest' | head -1)
[ -s "$manifest" ] || die "target manifest not generated"
initramfs=$(find "$target_dir" -maxdepth 1 -type f -name '*initramfs-uImage' | head -1)
sysupgrade=$(find "$target_dir" -maxdepth 1 -type f -name '*squashfs-sysupgrade.bin' | head -1)
[ -s "$initramfs" ] || die "initramfs-uImage not generated"
[ -s "$sysupgrade" ] || die "squashfs-sysupgrade.bin not generated"
for package in qca-nss-drv qca-nss-ecm-standard qca-nss-gmac; do
    grep -q "$package" "$manifest" || die "$package missing from manifest"
done
rootfs=$(find build_dir/target-* -type d -path '*/root-*' | head -1)
[ -n "$rootfs" ] || die "root filesystem staging directory not found"
for item in qca-nss-drv.ko qca-nss-gmac.ko ecm.ko; do
    find "$rootfs" -name "$item" -print -quit | grep . >/dev/null || die "$item missing from root filesystem"
done
for item in qca-nss0.bin qca-nss1.bin; do
    find "$rootfs" -name "$item" -print -quit | grep . >/dev/null || die "$item missing from root filesystem"
done
{
    echo "manifest=$manifest"
    sha256sum "$initramfs" "$sysupgrade"
    echo "build verification: PASS"
} | tee -a "$BUILD_LOG"
