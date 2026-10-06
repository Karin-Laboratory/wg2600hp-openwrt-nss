#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
OPENWRT_DIR=${OPENWRT_DIR:-"$ROOT/../openwrt-25.12.5-wg2600hp"}
NSS_FIRMWARE_DIR=${NSS_FIRMWARE_DIR:-}

if [ -z "$NSS_FIRMWARE_DIR" ] || [ ! -f "$NSS_FIRMWARE_DIR/qca-nss0-retail.bin" ] || [ ! -f "$NSS_FIRMWARE_DIR/qca-nss1-retail.bin" ]; then
    echo "NSS_FIRMWARE_DIR must contain qca-nss0-retail.bin and qca-nss1-retail.bin" >&2
    echo "Firmware blobs are intentionally not redistributed by this repository." >&2
    exit 2
fi

test -d "$OPENWRT_DIR" || { echo "missing OpenWrt checkout: $OPENWRT_DIR" >&2; exit 2; }
cp -a "$ROOT/packages/qca-nss-gmac/." "$OPENWRT_DIR/package/kernel/qca-nss-gmac/"
cp -a "$ROOT/packages/qca-nss-drv/." "$OPENWRT_DIR/package/kernel/qca-nss-drv/"
cp -a "$ROOT/packages/qca-nss-ecm/." "$OPENWRT_DIR/package/kernel/qca-nss-ecm/"
cp -a "$NSS_FIRMWARE_DIR/qca-nss0-retail.bin" "$OPENWRT_DIR/package/kernel/qca-nss-drv/files/nss-firmware/"
cp -a "$NSS_FIRMWARE_DIR/qca-nss1-retail.bin" "$OPENWRT_DIR/package/kernel/qca-nss-drv/files/nss-firmware/"
cp -a "$ROOT/patches/qca-nss-gmac/." "$OPENWRT_DIR/package/kernel/qca-nss-gmac/patches/"
cp -a "$ROOT/patches/qca-nss-drv/." "$OPENWRT_DIR/package/kernel/qca-nss-drv/patches/"
cp -a "$ROOT/patches/qca-nss-ecm/." "$OPENWRT_DIR/package/kernel/qca-nss-ecm/patches/"
cp -a "$ROOT/patches/openwrt-ipq806x/." "$OPENWRT_DIR/target/linux/ipq806x/patches-6.12/"
cp -a "$ROOT/config/wg2600hp.config.fragment" "$OPENWRT_DIR/wg2600hp.config.fragment"
cd "$OPENWRT_DIR"
if [ ! -f .config ]; then
    make defconfig
fi
cat wg2600hp.config.fragment >> .config
make defconfig
make -j1 V=s
