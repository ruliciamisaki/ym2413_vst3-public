# VST2413 FM シンセサイザー

![VST Compatible](docs/assets/VST_Compatible_Logo_Steinberg_with_TM.png)

[YM2413](https://ja.wikipedia.org/wiki/YM2413) (OPLL) をエミュレートする、VST3 インストゥルメントです。MSX の FM-PAC と Sega Master System で親しまれた音色を、現代の DAW で演奏・オートメーションできます。

これは [keijiro/vst2413](https://github.com/keijiro/vst2413) を基にした派生 VST3 ポートです。原版と同一であるとは主張しません。`source/emu2413/emu2413.c` には Windows でのビルド互換性のための最小変更があり、変更箇所は明示しています。

## 収録プラグイン

| プラグイン | 内容                                                                  |
| ---------- | --------------------------------------------------------------------- |
| VST2413P   | YM2413 内蔵プリセットを使う 9 音ポリフォニック音源                    |
| VST2413R   | YM2413 のリズム音源                                                   |
| VST2413S   | ユーザー音色（音色 0）をレジスタ単位で編集する 9 音ポリフォニック音源 |

VST2413S は、LEVEL (`TL`) と FEEDBACK (`FB`) を共通パラメータとして配置し、MODULATOR / CARRIER ごとに `EG`、`MUL`、`AR`、`DR`、`SL`、`RR`、`KSR`、`KSL`、`AM`、`VIB` と波形選択を公開します。`EG` は `0` / `1` の選択です。波形選択は YM2413 の Register 03h にある `DM` / `DC`（半波整流波形）です。資料によってはこれを「ディストーション」と呼ぶことがありますが、YM2413 の正式な独立した distortion レジスタではありません。

## すぐ使う

リリースした圧縮ファイルを展開し、`*.vst3` **フォルダー全体**を次のいずれかへコピーしてください。ファイル単体をコピーしても認識されません。

macOSの場合：
- 全ユーザー: `/Library/Audio/Plug-Ins/VST3`
- 現在のユーザーのみ: `~/Library/Audio/Plug-Ins/VST3`
Windowsの場合：
- 全ユーザー: `C:\Program Files\Common Files\VST3\`
- 現在のユーザーのみ: `%LOCALAPPDATA%\Programs\Common\VST3\`

その後 Cubase の Plug-in Manager で再スキャンします。実際の演奏と音作りは [docs/USAGE.md](docs/USAGE.md)、詳しい導入手順は [docs/INSTALL.md](docs/INSTALL.md) を見て。ビルドは [docs/BUILD.md](docs/BUILD.md)、公開前の確認は [docs/RELEASE.md](docs/RELEASE.md) を参照してください。

## ライセンスと謝辞

配布・改変・商用利用は、同梱する第三者通知を守る限り可能です。特に emu2413 の原文通知を削除・改変せず、改変版であることを明示してください。法的な通知の原文と配布時の要件は [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)、由来とこのポートの変更は [NOTICE.md](NOTICE.md)、謝辞は [ACKNOWLEDGMENTS.md](ACKNOWLEDGMENTS.md) にまとめています。

VST および VST Compatible ロゴは Steinberg Media Technologies GmbH の商標です。このプロジェクトは Steinberg または原版作者による承認・支援・提携を意味しません。

---

# VST2413 FM Synthesizer

![VST Compatible](docs/assets/VST_Compatible_Logo_Steinberg_with_TM.png)

A 64-bit VST3 instrument that emulates [YM2413](https://en.wikipedia.org/wiki/Yamaha_YM2413) (OPLL). It brings the familiar sound of MSX FM-PAC and Sega Master System hardware into a modern DAW, with automatable parameters.

This is a derived VST3 port of [keijiro/vst2413](https://github.com/keijiro/vst2413). It is not represented as the original work. `source/emu2413/emu2413.c` contains a small, explicitly marked Windows build-compatibility change.

## Included plug-ins

| Plug-in  | Purpose                                                              |
| -------- | -------------------------------------------------------------------- |
| VST2413P | Nine-voice instrument using YM2413 factory presets                   |
| VST2413R | YM2413 rhythm instrument                                             |
| VST2413S | Nine-voice instrument with register-accurate editing of user patch 0 |

VST2413S exposes LEVEL (`TL`) and FEEDBACK (`FB`) as shared controls, and `EG`, `MUL`, `AR`, `DR`, `SL`, `RR`, `KSR`, `KSL`, `AM`, `VIB`, and waveform selection for each MODULATOR and CARRIER. `EG` is a `0` / `1` choice. The waveform controls are the YM2413 Register 03h `DM`/`DC` bits (half-wave rectification); some reference material calls them "distortion", but YM2413 has no separate official distortion register.

## Quick start

Extract a release archive and copy the complete `*.vst3` **folder** to one of these locations. Do not copy only the file inside the bundle.

macOS:
- All users: `/Library/Audio/Plug-Ins/VST3`
- Current user only: `~/Library/Audio/Plug-Ins/VST3`
Windows：
- All users: `C:\Program Files\Common Files\VST3\`
- Current user only: `%LOCALAPPDATA%\Programs\Common\VST3\`

Then rescan plug-ins in Cubase Plug-in Manager. See [docs/USAGE.md](docs/USAGE.md) for playing and sound design, [docs/INSTALL.md](docs/INSTALL.md) for installation details, [docs/BUILD.md](docs/BUILD.md) for building, and [docs/RELEASE.md](docs/RELEASE.md) for the publication checklist.

## License and acknowledgements

Distribution, modification, and commercial use are permitted when the bundled third-party notices are observed. In particular, retain the emu2413 notice without alteration and plainly mark altered source versions. The complete legal notices and distribution requirements are in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md); provenance and port changes are in [NOTICE.md](NOTICE.md); acknowledgements are in [ACKNOWLEDGMENTS.md](ACKNOWLEDGMENTS.md).

VST and the VST Compatible logo are trademarks of Steinberg Media Technologies GmbH. This project is not endorsed by, sponsored by, or affiliated with Steinberg or the original author.
