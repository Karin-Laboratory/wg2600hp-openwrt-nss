# Build notes

ビルド成功記録はOpenWrt `f0a60eee`、Linux `6.12.94`、GCC `14.3.0`、musl、ARM Cortex-A15で取得した。作業中のbuild_dir、staging_dir、tmp、download cacheは公開していない。

package sourceはCodelinaro git revisionから取得する。Makefileのmirror hashは記録済みtarballの値に固定しているが、上流ミラーの再生成形式が変わる場合はhashを盲目的に変更せず、revisionと取得物を再確認すること。

ビルドは `make -j1 V=s` を推奨する。並列実行停止が発生した場合は、コンパイラ診断と外部プロセス終了を区別し、ログを保存してから再実行する。
