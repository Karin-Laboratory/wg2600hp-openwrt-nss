# Hardware test TODO

実機試験はまだ一切行っていない。開始時は各段階のUARTログと復旧手段を保存する。

1. WG2600HPの型番、既存firmware、flashバックアップ、電源・UART経路を確認。
2. initramfs-uImageをTFTP RAM bootし、kernel logとNSS firmware requestだけを確認。
3. GMAC/DSAのprobe、WAN/LANのリンク、最小の有線通信を個別確認。
4. Wi-Fi calibration、無線起動、ECM/conntrack/offloadを個別確認。
5. 失敗時にsysupgradeを行わず、UART/TFTPで復旧。十分な証拠が揃った場合のみsysupgradeを別案件として検討。

このTODOは導入手順や実機へのflash許可ではない。
