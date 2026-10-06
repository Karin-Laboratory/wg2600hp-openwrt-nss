# Linux 5.15系から6.12.94への移植メモ

| 領域 | 6.12での対応 |
|---|---|
| sysctl | 廃止された `ctl_table.child` / `register_sysctl_table()` をflat tableと `register_sysctl()` に変更。handlerはconst tableを受ける。 |
| GCC14 | `-Wmissing-prototypes`で露呈した非static関数の宣言をheaderへ追加。内部関数はstatic化。enum conversionも明示的に処理。 |
| DMA/cache | 古い `dmac_inv_range` / `dmac_clean_range` 前提を6.12のDMA/cache helperへ移行。NULL device前提の経路を修正。 |
| NAPI/netdev | `netif_napi_add()`からweight付きAPIへ移行。MAC address helperとplatform driver removeの新しい型へ追従。 |
| PPTP/PPP | `sk_buff`、`napi_struct`、`net_device`の前方宣言、PPP/PPTP state参照、HAL prototypeを補正。 |
| bridge/FDB | private実装へ直接依存せず、6.12用の狭いcompat wrapper経由でFDB更新を行う。 |
| `priv_flags_ext` | netdev extensionの6.12表現に合わせ、ECMからの参照をcompat化。 |
| Wi-Fi notifier | notifier callbackとprototypeを6.12の型へ合わせる。 |
| conntrack/DSCP | conntrack event/extensionの型とDSCP remark extension fieldsを補正。 |
| FIB notifier | notifier登録・callbackの6.12 APIへ移行。IPv6 private helperはwrapperで接続。 |

この表は設計上の要約であり、実機での各経路の動作確認結果ではない。詳細は各patchのcommit messageとhunkを参照すること。
