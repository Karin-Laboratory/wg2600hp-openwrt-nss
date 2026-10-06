# Patchset provenance

この一覧は公開patchを、移植時に作成・修正したものと既存lineage由来のものに分けるための監査台帳である。patch本文の先頭に上流commitがある場合はそれを優先し、ない場合は package Makefile と取得元revisionを根拠にする。

| patch filename | component | origin | original repository/commit | unchanged / modified / newly created | Linux 6.12 portとの関係 |
|---|---|---|---|---|---|
| '0026-netfilter-add-dscp-remark-conntrack-extension.patch' | OpenWrt ipq806x | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0027-netfilter-dscpremark-ecm-fields.patch' | OpenWrt ipq806x | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0040-linux-6.12-ecm-bridge-ppp-compat.patch' | OpenWrt ipq806x | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0041-linux-6.12-ecm-ipv6-compat-exports.patch' | OpenWrt ipq806x | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '999-005-wg2600hp-nss-minimal-6.12.patch' | OpenWrt ipq806x | ButlerX | See patch header; source revision recorded in Makefile | newly created | direct 6.12 port or integration |
| '0001-kernel-5.4-support.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0002-Control-fab-scaling-from-package-Makefile.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0003-qca-nss-qdisc-support.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0004-fix-ioremap-call.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0005-fix-NULL-pointer-exception.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0006-Fix-Kernel-Panic-dma-with-NULL-dev.patch' | qca-nss-drv | ButlerX port | See patch header; source revision recorded in Makefile | modified | pre-existing compatibility lineage |
| '0007-Exported-set-nexthop-function.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0008-QSDK-11.2.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0009-kernel-5.15-support.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0011-treewide-hack-support-for-mismatched-firmware.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0012-Makefile-modularize-driver.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0013-backport-12.1.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0014-revert-tunipip6-11.2.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0015-fix-mismatched-stats-for-nss-11.0-fw.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0016-kernel-6.12-gcc14-compat.patch' | qca-nss-drv | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0017-kernel-6.12-nss-ipv6-sysctl.patch' | qca-nss-drv | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0018-kernel-6.12-sysctl-leaf-and-pptp-types.patch' | qca-nss-drv | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0019-kernel-6.12-nss-hal-api.patch' | qca-nss-drv | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | direct 6.12 port or integration |
| '0020-kernel-6.12-nss-freq-prototypes.patch' | qca-nss-drv | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0021-kernel-6.12-nss-freq-log-prototype.patch' | qca-nss-drv | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0022-kernel-6.12-nss-freq-stats-prototype.patch' | qca-nss-drv | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0028-kernel-6.12-dma-cache-api.patch' | qca-nss-drv | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0001-add-versioning.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0001-treewide-componentize-the-module-even-more.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0002-treewide-rework-ipv6_dev_find_and_hold-to-internal-A.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0003-treewide-rework-debugfs-api-to-new-implementation.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0004-treewide-fix-wrong-chain-events-flag.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0005-qca-nss-ecm-resolve-the-cpu-high-load-regarding-ecm.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0006-ecm_interface-switch-to-kernel_recvmsg-api.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0007-treewide-rework-notifier-changes-for-5.15.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0008-frontends-drop-use-of-static-be_liberal-and-no_windo.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0009-ecm_tracker_datagram-drop-static-for-EXPORT_SYMBOL.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0010-frontends-drop-udp_get_timeouts-and-use-standard-ups.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0011-ecm_interface-rework-vlan-API-to-internal-function.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0012-ecm_interface-rework-br_dev_update_stats-to-internal.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0013-ecm_classifier_nl_genl-kernel-5.10-support.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0014-qca-nss-ecm-fix-a-memcpy-overflow-in-ecm_db.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0015-example-fix-compile-pcc-example.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0016-kernel-6.12-gcc14-ecm-ae-prototype.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0017-kernel-6.12-gcc14-ecm-ae-internal-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0018-kernel-6.12-unaligned-header.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | direct 6.12 port or integration |
| '0019-kernel-6.12-ecm-bridge-and-ipv4-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0020-kernel-6.12-netdev-extension-compat.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0021-kernel-6.12-ecm-current-netdev-and-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0022-kernel-6.12-gcc14-ecm-tracker-udp-internal.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0023-kernel-6.12-gcc14-ecm-tracker-tcp-internal.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0024-kernel-6.12-gcc14-ecm-tracker-datagram-internal.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0025-kernel-6.12-gcc14-ecm-tracker-module-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0026-kernel-6.12-sysctl-registration.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0027-kernel-6.12-sysctl-flat-tables.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0028-kernel-6.12-ecm-sysctl-handler-compat.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0029-kernel-6.12-ecm-fib-notifier-compat.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0030-kernel-6.12-ecm-db-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0031-kernel-6.12-ecm-strscpy.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | direct 6.12 port or integration |
| '0032-kernel-6.12-ecm-mapping-stats-prototype.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0033-kernel-6.12-gcc14-ecm-host-stats-prototype.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0034-kernel-6.12-gcc14-ecm-node-stats-prototype.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0035-kernel-6.12-ecm-iface-strscpy.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | direct 6.12 port or integration |
| '0036-kernel-6.12-gcc14-ecm-default-classifier-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0037-kernel-6.12-ecm-current-notifier-apis.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | direct 6.12 port or integration |
| '0038-kernel-6.12-ecm-ppp-fdb-interface-compat.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0039-kernel-6.12-ecm-wifi-event-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0040-kernel-6.12-ecm-conntrack-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0041-kernel-6.12-ecm-ipv6-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0042-kernel-6.12-ecm-non-ported-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0043-kernel-6.12-ecm-tcp-and-nss-prototype-compat.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0044-kernel-6.12-ecm-ipv6-nss-prototype-compat.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0045-kernel-6.12-ecm-dscp-nl-compat.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0046-kernel-6.12-ecm-nss-remaining-compat.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0047-kernel-6.12-ecm-final-nss-state-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0048-kernel-6.12-ecm-ipv6-private-wrapper-compat.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0049-kernel-6.12-ecm-ipv6-callsite-compat.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0053-kernel-6.12-ecm-exported-tracker-linkage.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | direct 6.12 port or integration |
| '0054-kernel-6.12-ecm-tracker-datagram-prototypes.patch' | qca-nss-ecm | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '902-ecm-conntrack-notifier-introduce-init-and-exit-mutex.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '903-lock-this-cpu.patch' | qca-nss-ecm | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0000-kernel-5.10-support.patch' | qca-nss-gmac | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0008-add-extra-logging.patch' | qca-nss-gmac | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0009-add-tstamp-enable-func-ethtool.patch' | qca-nss-gmac | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0010-irq_of_parse_and_map-retcode.patch' | qca-nss-gmac | ACwifidude/nss-packages + QSDK | See patch header; source revision recorded in Makefile | unchanged/modified | pre-existing compatibility lineage |
| '0011-kernel-6.12-gcc14-compat.patch' | qca-nss-gmac | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0012-kernel-6.12-gcc14-internal-prototypes.patch' | qca-nss-gmac | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |
| '0013-kernel-6.12-gcc14-mii-reset-internal.patch' | qca-nss-gmac | ButlerX port | See patch header; source revision recorded in Makefile | modified | direct 6.12 port or integration |

## 読み方

- 'ACwifidude/nss-packages + QSDK' はACwifidudeの公開patch列またはその元になったCodelinaro/QSDK実装を、現在のpackageへ取り込んだもの。
- 'ButlerX port' はLinux 6.12.94/GCC 14.3.0で必要になった修正、またはその統合に伴う変更。上流へmerge済みであることを意味しない。
- 'ButlerX' の '999-005-wg2600hp-nss-minimal-6.12.patch' はWG2600HP向けDTS/NSS統合として今回作成したpatchで、SHA256は 'd477947eaf13bc9fb4d766e175992e82967d7f2e03c8374e7e0b3bb37cf15f86'。
- 'unchanged/modified' と記したものは、名前・機能のlineageは追えるが、5.15用原文を6.12へそのまま適用したものではない。実際の変更範囲はpatch hunkで確認すること。
