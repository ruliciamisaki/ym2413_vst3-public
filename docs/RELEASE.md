# 公開前チェックリスト / Release checklist

## 日本語

1. `source/emu2413/readme.txt` が原文のまま残っていること、`source/emu2413/emu2413.c` の改変表示が残っていることを確認します。
2. `THIRD_PARTY_NOTICES.md`、`NOTICE.md`、`ACKNOWLEDGMENTS.md`、`docs/` と VST Compatible ロゴを配布物に同梱します。Windows ZIP は `scripts/package-release.ps1`、macOS DMG は `scripts/package-release-macos.sh` がこれを行います。
3. Windows では `scripts/build-windows.ps1` を実行し、各 `.vst3` に対して VST3 validator と Cubase Pro 13 の読み込み・発音を確認します。
4. macOS では `scripts/build-macos.sh` を実行し、universal binary（x86_64 / arm64）であることと DAW での読み込み・発音を確認します。macOS 版はコード署名・公証を行っていないため、リリースノートにその旨を明記します。
5. 各 `vst3/Vst2413*Factory.cpp` の `BEGIN_FACTORY_DEF` URL が `https://github.com/ruliciamisaki/ym2413_vst3-public` であることを確認します。原版の URL は設定せず、権利者による承認があるような表示を避けます。
6. `origin` がこの公開用リポジトリを指し、旧 VST2 プロジェクト、ビルド生成物、VST3 SDK 本体、private リポジトリの履歴が含まれていないことを確認します。

```powershell
git remote get-url origin
git ls-files
```

これは法的助言ではありません。商号、配布地域、商用サポート、署名証明書など固有の条件がある場合は、公開前に専門家へ確認してください。

## English

1. Verify that `source/emu2413/readme.txt` is retained verbatim and that the altered-source marker remains in `source/emu2413/emu2413.c`.
2. Include `THIRD_PARTY_NOTICES.md`, `NOTICE.md`, `ACKNOWLEDGMENTS.md`, `docs/`, and the VST Compatible logo in the release packages. `scripts/package-release.ps1` (Windows ZIP) and `scripts/package-release-macos.sh` (macOS DMG) do this.
3. On Windows, run `scripts/build-windows.ps1`, then validate each `.vst3` with the VST3 validator and by loading and playing it in Cubase Pro 13.
4. On macOS, run `scripts/build-macos.sh`, then confirm that the bundles are universal binaries (x86_64 / arm64) and that they load and play in a DAW. The macOS build is not code-signed or notarized; state this in the release notes.
5. Verify that the `BEGIN_FACTORY_DEF` URL in every `vst3/Vst2413*Factory.cpp` is `https://github.com/ruliciamisaki/ym2413_vst3-public`. Do not use the original-project URL; this avoids implying endorsement by its copyright holder.
6. Verify that `origin` points to this public repository and that the old VST2 projects, build outputs, VST3 SDK checkout, and private-repository history are not included.

```powershell
git remote get-url origin
git ls-files
```

This checklist is not legal advice. Consult a qualified professional before release if your trade name, distribution territory, commercial support, or signing certificate imposes additional requirements.
