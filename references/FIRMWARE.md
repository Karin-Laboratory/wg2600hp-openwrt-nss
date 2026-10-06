# NSS firmware provenance

このリポジトリはNSS blobを再配布しない。以下は、最終成功ビルドで実際に使った2つのblobを、第三者が同一性判定できるようにした記録である。

| image内名 | 取得時の元ファイル名 | byte size | SHA256 | header |
|---|---|---:|---|---|
| `qca-nss0.bin` | `qca-nss0-retail.bin` | 544712 | `265d0a87b527f7c6c441af166bcc8a762ee23bfdc515585de29034f214cd481d` | NSS 11.4 (`NSS_FW_VERSION_MAJOR=11`, `MINOR=4`) |
| `qca-nss1.bin` | `qca-nss1-retail.bin` | 218860 | `b09c5646550f9e7fbd916daf6f6a7975b66fdfd1faf0960b1e624b4708008b79` | NSS 11.4 (`NSS_FW_VERSION_MAJOR=11`, `MINOR=4`) |

## Provenance and extraction

- 元製品: Synology RT2600ac
- SRM: `1.2-7742-4`（SRM 1.2系列）
- 取得経路: `https://archive.synology.com/download/SRM/release/1.2/7742/` から取得した対象SRMパッケージを、利用者自身のライセンス確認のもとで展開したもの。作業時の公開上流記録は [ACwifidude/nss-packages](https://github.com/ACwifidude/nss-packages/tree/2fcff66d5279156bc67034a3547528a5fd48b0b2)、branch `NSS-11.2-K5.15`、commit `2fcff66d5279156bc67034a3547528a5fd48b0b2` にある。
- archive内の場所: `qca-nss-drv/files/nss-firmware/qca-nss0-retail.bin` と `qca-nss-drv/files/nss-firmware/qca-nss1-retail.bin`。元SRM package内の内部パスは、公開記録だけでは確定できないため推測しない。
- 抽出方法: SRM packageをローカルに展開し、ACwifidudeの上記packageにある2ファイルを採用した。blobはGitへ追加していない。
- headerの根拠: `qca-nss-drv/files/nss-firmware/nss_fw_version.h` の `11.4`。これはblobの実行試験を意味しない。

## Build and image placement

利用者が `NSS_FIRMWARE_DIR` に2ファイルを置く。`scripts/build.sh` がsizeとSHA256を検証した後、次のように配置する。

| 段階 | 配置 |
|---|---|
| input | `$NSS_FIRMWARE_DIR/qca-nss{0,1}-retail.bin` |
| package overlay | `package/kernel/qca-nss-drv/files/nss-firmware/qca-nss{0,1}-retail.bin` |
| installed image | `/lib/firmware/qca-nss{0,1}.bin` |

再配布条件を十分確認できていないため、blobおよびblobを含む生成binaryは公開していない。利用者自身が元製品・SRM package・Qualcomm Atherosの条件を確認すること。
