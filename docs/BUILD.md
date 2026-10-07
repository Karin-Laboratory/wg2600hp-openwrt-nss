# 第三者向けclean-room build

## 前提

最終成功記録は Debian系 Linux x86_64 host、OpenWrt `v25.12.5` release commit `f0a60eee2fe051741c643ea6118718aae1ef17fb`、ARM Cortex-A15/musl toolchain、Linux `6.12.94`で取得した。目安としてRAM 8 GiB以上、空きディスク 30 GiB以上を用意する。フルビルドは大量の一時ファイルを作る。

必要なhost packageは、OpenWrt公式の Debian/Ubuntu build prerequisites（`build-essential`, `clang`, `flex`, `bison`, `gawk`, `gettext`, `git`, `libncurses-dev`, `libssl-dev`, `python3`, `rsync`, `unzip`, `wget`, `zlib1g-dev`, `file`, `xsltproc`）である。`build.sh`はsysupgrade wrapper内部を直接`unsquashfs`する検証を行わないため、`squashfs-tools`は必須ではない。

## 手順

```sh
git clone https://github.com/openwrt/openwrt.git openwrt-25.12.5
cd openwrt-25.12.5
git checkout f0a60eee2fe051741c643ea6118718aae1ef17fb
cd ..
git clone https://github.com/Karin-Laboratory/wg2600hp-openwrt-nss.git
```

Synology RT2600ac SRM `1.2-7742-4`由来の `qca-nss0-retail.bin` と `qca-nss1-retail.bin` を、各自のライセンス確認後に用意する。サイズとSHA256は [FIRMWARE.md](../references/FIRMWARE.md) と同じでなければならない。

```sh
cd wg2600hp-openwrt-nss
OPENWRT_DIR=$PWD/../openwrt-25.12.5 \
NSS_FIRMWARE_DIR=$HOME/nss-firmware \
./scripts/build.sh
```

`build.sh`はOpenWrt commit、Git statusが完全に空のclean checkout（tracked変更・staged変更・untrackedファイルを拒否）、生成物ディレクトリ、firmware size/SHA256を検査し、feed準備、package overlay、patch overlay、公開config fragment、`make defconfig`、`make -j1 V=s`を順に実行する。パイプラインはBashの`pipefail`で左側の失敗も検出する。配置先は次のとおりである。

| 公開物 | OpenWrt内の配置先 |
|---|---|
| `packages/qca-nss-*` | `package/kernel/qca-nss-*` |
| `patches/qca-nss-*` | `package/kernel/qca-nss-*/patches/` |
| `patches/openwrt-ipq806x` | `target/linux/ipq806x/patches-6.12/` |
| `config/wg2600hp.config.fragment` | OpenWrt rootの初期 `.config` |
| firmware blobs | `package/kernel/qca-nss-drv/files/nss-firmware/` |

既定の`BUILD_JOBS=1`では`make -j1 V=s`を実行し、初回の全ログを保存する。時間とRAMに余裕がある場合だけ、`BUILD_JOBS=8`のように並列度を明示できる。各`command | tee`は`set -euo pipefail`によりcommand側の失敗で停止する。

生成物は `bin/targets/ipq806x/generic/` に出る。manifest、initramfs-uImage、squashfs-sysupgrade.bin、`qca-nss-drv.ko`、`qca-nss-gmac.ko`、`ecm.ko`、`qca-nss0.bin`、`qca-nss1.bin`をスクリプトが確認する。

## 再現性の定義

同一OpenWrt commit、同一公開patch/package、同一config fragment、同一firmware blobを使うことを再現条件とする。package version、kernel version、DTB、NSS modulesの存在、firmware SHA256、manifest内容がPASS条件である。ビルド時刻・署名・圧縮順序などのため、現段階では生成imageのbit-identical SHA256を保証しない。`checksums/IMAGE-SHA256SUMS-20261005` と `checksums/IMAGE-SHA256SUMS-20261007` は各build時点の記録であり、再ビルドで一致しなかった場合は差分理由を記録する。

## Troubleshooting

- `Config.in` error: package overlayが完全にコピーされているか確認する。
- commit error: `git rev-parse HEAD`が指定full SHAか確認する。
- firmware hash error:別SRM version、別製品、別blobを使っている。置き換えて再実行する。
- patch reject:既存build treeを使わず、release commit直後のclean checkoutからやり直す。
- `No child processes`、Hangup、Terminate: compiler診断とは限らない。build log末尾とhostの外部終了要因を保存し、`-j1 V=s`で再実行する。
