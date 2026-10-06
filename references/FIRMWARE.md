# NSS firmware provenance

対象blob:

- `qca-nss0.bin` / source filename `qca-nss0-retail.bin`: 544,712 bytes
- `qca-nss1.bin` / source filename `qca-nss1-retail.bin`: 218,860 bytes
- firmware header: NSS major 11 / minor 4

作業ツリーでの配置元は `qca-nss-drv/files/nss-firmware/`、イメージ内の配置先は `/lib/firmware/qca-nss0.bin` と `/lib/firmware/qca-nss1.bin` だった。公開リポジトリにはblobを含めていない。

同梱の `LICENSE.TXT` は binary redistribution 条件を含む一方、`NOTICE.TXT` には Qualcomm Atheros Confidential and Proprietary の記載がある。公開GitHubへの再配布可否を十分に確認できないため、取得元 revision と hash の記録・ビルド時のローカル配置方法だけを公開し、blobそのものは再配布しない。
