# WG2600HP NSS on OpenWrt 25.12.5

What this is: a public development record for a WG2600HP NSS port.
Target: NEC Aterm WG2600HP / Qualcomm IPQ8064.
Base: OpenWrt 25.12.5 / Linux 6.12.94 with qca-nss-gmac, qca-nss-drv, and qca-nss-ecm.
Build succeeds, but it is NOT tested on hardware. DO NOT FLASH.
NSS firmware blobs are not redistributed; users must provide and verify them locally.

> ## EXPERIMENTAL / UNTESTED ON HARDWARE
>
> **ビルド成功のみ確認済みです。実機へ flash しないでください。**
> **UART、TFTP RAM boot、flash、sysupgrade、NSS実動作、LAN/WAN、無線は一切未実施です。**
> **現在公開している内容は開発途中のものです。実機動作済みファームの配布ではありません。**

NEC Aterm WG2600HP（IPQ8064）向けに、OpenWrt 25.12.5 / Linux 6.12.94へ、既存のQualcomm NSS実装を移植した開発記録です。目的は実機用firmwareの配布ではなく、第三者が差分と再現手順を追跡できる状態を作ることです。

## 到達点

- OpenWrt toolchain（GCC 14.3.0、musl、ARM Cortex-A15）を構築
- Linux 6.12.94、kernel、DTB、modulesを生成
- `qca-nss-gmac`、`qca-nss-drv`、`qca-nss-ecm` の clean prepare / compile / link / modpost / `.ko` / APK生成に成功
- WG2600HPのNSS DTS/interface統合を適用
- initramfs-uImageとsquashfs-sysupgrade.binの生成に成功
- イメージ内の `qca-nss0.bin` / `qca-nss1.bin` の存在を静的確認

これはprobe成功、boot成功、通信成功、offload成功を意味しません。

## 再現対象とupstream provenance

| 項目 | 値 |
|---|---|
| OpenWrt | 25.12.5 / `f0a60eee2fe051741c643ea6118718aae1ef17fb`（build `r33051-f5dae5ece4`） |
| Kernel | Linux 6.12.94 |
| Target | `ipq806x/generic`, `DEVICE_nec_wg2600hp` |
| Toolchain | GCC 14.3.0, musl, `arm_cortex-a15_neon-vfpv4` |
| NSS driver | qca-nss-drv `3cfb9f43` |
| NSS GMAC | qca-nss-gmac `171767947467662f2407d0cfff26dfb136c3fb4a` |
| NSS ECM | qca-nss-ecm `db66c47` |

`f0a60eee2fe051741c643ea6118718aae1ef17fb` はOpenWrt v25.12.5のrelease commitで、`r33051-f5dae5ece4` はそのtreeに埋め込まれたVERSION_CODEである。同じreleaseを指すため、両者は矛盾しない。

| repository | branch/tag | commit | 利用/参考範囲 |
|---|---|---|---|
| [OpenWrt](https://github.com/openwrt/openwrt) | v25.12.5 | `f0a60eee2fe051741c643ea6118718aae1ef17fb` | clean base tree |
| [ACwifidude/openwrt](https://github.com/ACwifidude/openwrt) | `openwrt-23.05-nss-qsdk11` | `cd265bb1a5229aec79aa675d9c2f0289ca75e684` | WG2600HP/IPQ806x DTS and 5.15 integration reference |
| [ACwifidude/nss-packages](https://github.com/ACwifidude/nss-packages) | `NSS-11.2-K5.15` | `2fcff66d5279156bc67034a3547528a5fd48b0b2` | package layout, Config.in, firmware record, 11.0 IPQ806x driver selection |
| Codelinaro/QSDK `nss-drv` | source date 2020-03-20 | `3cfb9f43` | driver source |
| Codelinaro/QSDK `nss-gmac` | source date 2021-04-20 | `171767947467662f2407d0cfff26dfb136c3fb4a` | GMAC source |
| Codelinaro/QSDK `qca-nss-ecm` | source date 2023-01-20 | `db66c47` | ECM source |
| [asvio/nbg7815-nss](https://github.com/asvio/nbg7815-nss) | default branch at audit | `82f5118bd4eea40c64de36b967c89aea007c8cc6` | architecture and compatibility discussion only; IPQ807x/IPQ6018, not WG2600HP source |

これらは、各componentのsource・patch・設計資料の出典または参考実装である。本リポジトリがそれらの上流であること、または上流の動作保証を引き継ぐことを意味しない。

## 6.12互換層の概要

移植は機能を無効化するのではなく、6.12/GCC14で変わったAPIと可視性を明示的に追従させています。

- **GMAC**: `netif_napi_add_weight()`、MAC address helper、`strscpy()`、sysctl handlerのconst、platform `.remove` void化、内部prototype。
- **DRV**: `register_sysctl()`によるflat sysctl登録、sysctl handler const、DMA/cache APIとskb recycle、PPTP/NAPI/HALの型・前方宣言、GCC14 `-Wmissing-prototypes`、firmware世代に合わせた統計配列。
- **ECM**: sysctl flat table、`strscpy()`、conntrack/DSCP、FIB/current notifier、bridge/FDB、PPP/PPTP、`priv_flags_ext`、Wi-Fi notifier、内部/公開prototype、IPv6 wrapper、tracker linkage。
- **Kernel/OpenWrt**: ECMが必要とするDSCP conntrack extension、bridge/PPP compatibility wrapper、IPv6 compatibility exportを追加。
- **DTS**: 公式25.12.5 WG2600HPのQCA8337/DSA構成を基準に、NSS core 0/1とNSS GMAC resource/interfaceを追加。

各変更は `patches/` の番号付きpatchで追跡できます。元の5.15系patchを機械的に適用したものではありません。

## ビルド

OpenWrt全体のコピーは収録していません。clean checkoutへ、対応するpackage overlay、patch、config fragmentを配置して再現します。

一本道の手順と配置表は [`docs/BUILD.md`](docs/BUILD.md) にまとめています。clean checkoutとblobを用意した後、`OPENWRT_DIR=... NSS_FIRMWARE_DIR=... ./scripts/build.sh` の1コマンドで実行します。scriptは既存 `.config` や `build_dir` を受け付けず、公開fragmentから生成します。

## Documentation

- [Status](docs/STATUS.md)
- [Build guide](docs/BUILD.md)
- [Porting notes](docs/PORTING-NOTES.md)
- [Patchset provenance](docs/PATCHSET.md)
- [Hardware test TODO](docs/HARDWARE-TEST-TODO.md)
- [Build result 2026-10-05](docs/BUILD-RESULT-20261005.txt)
- [Firmware provenance](references/FIRMWARE.md)
- [Recorded image SHA256](checksums/IMAGE-SHA256SUMS)

## 生成確認記録

実機未検証のため、binary本体は公開しません。サイズとSHA256だけを `checksums/IMAGE-SHA256SUMS` および `docs/BUILD-RESULT-20261005.txt` に記録しています。

| 生成物 | サイズ | SHA256 |
|---|---:|---|
| initramfs-uImage | 7,938,306 | `a3219fabd11a71917b9857ee731d47706468629a06969c20acf17a28b3c662fd` |
| squashfs-sysupgrade.bin | 8,323,615 | `833d4b2772bafef9360e88e8e89c739ec223d7c72a32bdf5bf5e2c8c1b2e8122` |
| 最終DTS統合patch | — | `d477947eaf13bc9fb4d766e175992e82967d7f2e03c8374e7e0b3bb37cf15f86` |

## 未検証事項と既知の問題

実機の起動、UART/TFTP、flash/sysupgrade、kernel panic、NSS firmware load、GMAC attach、DSA topology、WAN/LAN、Wi-Fi、ECM offload、性能、復旧手順はすべて未検証です。従って、この成果物を実機へ書き込まないでください。WG2600HP3も対象外です。

## 今後の検証順序

バックアップとUART接続を準備したうえで、静的DTB確認、TFTP RAM boot、serial log収集、firmware/NSS probe、LAN最小通信、WAN、Wi-Fi、ECM/offload、最後に限定的なsysupgradeの順に、各段階で復旧可能性を確認して進めます。このリポジトリの公開時点では、どの段階も開始していません。

## ライセンスと再配布

OpenWrtおよび各ソースのライセンスは各上流ソースと同梱noticeに従います。NSS firmwareはQualcomm Atherosのバイナリで、同梱LICENSE.TXTには再配布条件と reverse engineering 禁止等の制限がありますが、公開リポジトリでの再配布許可をこの記録だけでは確定できません。そのため `qca-nss0.bin` / `qca-nss1.bin` は収録していません。取得元、revision、hash、配置方法だけを `references/FIRMWARE.md` に記載しています。

公開再配布条件を十分確認できていないため、blobおよびblobを含む生成binaryは公開していません。生成image全体を一律に再配布禁止と断定するものではなく、利用者自身が各構成要素のライセンス条件を確認してください。

本資料は研究・再現用の開発記録です。OpenWrt、Qualcomm、NECの公式サポートや実機互換性を示すものではありません。
