# Status

最終更新: 2026-10-07 JST

## 判定

`BUILD PASS / CLEAN-ROOM BUILD PASS / HARDWARE TEST NOT RUN`

ビルドシステム上の kernel、DTB、modules、NSS three modules、APK、initramfs、sysupgrade生成は成功した。これは実機の起動・動作・互換性を保証しない。

最新のclean-room記録は [`BUILD-RESULT-20261007.txt`](BUILD-RESULT-20261007.txt) である。2026-10-05のInitial buildとは分けて管理している。

## 実施していないこと

UART、TFTP RAM boot、flash、sysupgrade、erase、LAN/WAN、Wi-Fi、NSS firmware実行確認、ECM offload確認、性能測定は一切実施していない。不可逆なeFuse、Secure Boot、Flash Encryption、JTAG設定も変更していない。

## 記録の扱い

`docs/BUILD-RESULT-20261005.txt` は最終ビルドの静的記録、`patches/` は再利用可能な差分、`config/` は秘密情報を含まないconfig fragmentである。巨大なOpenWrt source tree、build cache、download cache、生成binaryは収録していない。
