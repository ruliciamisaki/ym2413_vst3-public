# ビルド / Build

## 日本語

VST3 SDK（MIT ライセンス）は [vcpkg](https://vcpkg.io/) のマニフェストモードで取得します。公式ポートは VSTGUI と CMake ヘルパーを含まないため、SDK ソース一式（VSTGUI 込み）を導入するオーバーレイポート [`ports/vst3sdk-source`](../ports/vst3sdk-source) を使います。固定対象は VST3 SDK `v3.8.1_build_84` です。CMake 構成時に vcpkg が自動で取得するため、手動の SDK チェックアウトは不要です（`-DVST3_SDK_ROOT=...` で任意の SDK を指定することもできます）。

配布バイナリより、各自の環境でビルドすることを推奨します。以下に OS ごとのツール導入コマンドを示します。

### Windows（検証済み）

必要なもの:

- Visual Studio 2026 または Build Tools の「Desktop development with C++」
- CMake 4.2 以上（Visual Studio 2026 の CMake ジェネレーターに必要）
- vcpkg（`VCPKG_ROOT`）

#### ツールのインストール（Chocolatey）

管理者権限の PowerShell で実行します。

```powershell
choco install -y visualstudio2026buildtools --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"
choco install -y cmake --installargs 'ADD_CMAKE_TO_PATH=System'
choco install -y git
```

vcpkg は Git で取得してブートストラップし、`VCPKG_ROOT` を設定します（新しいターミナルで有効になります）。

```powershell
git clone https://github.com/microsoft/vcpkg.git C:\vcpkg
C:\vcpkg\bootstrap-vcpkg.bat -disableMetrics
[Environment]::SetEnvironmentVariable('VCPKG_ROOT', 'C:\vcpkg', 'User')
```

#### ビルド

**Developer PowerShell for VS 2026** から:

```powershell
.\scripts\build-windows.ps1
```

生成物は `build\VST3\Release\VST2413P.vst3`、`VST2413R.vst3`、`VST2413S.vst3` です。各 `.vst3` はフォルダー単位で扱ってください。SDK を含めない ZIP を作るには:

```powershell
.\scripts\package-release.ps1 -Version 1.0.0
```

### macOS（検証済み）

必要なものは Xcode または Xcode Command Line Tools、CMake 3.25 以上、vcpkg（`VCPKG_ROOT`）です。スクリプトは universal binary を指定します。Command Line Tools のみの場合は、SDK の Xcode バージョン検査を通すため `XCODE_VERSION` を自動設定します。

#### ツールのインストール（Homebrew）

```bash
xcode-select --install          # Command Line Tools（Xcode 本体があれば不要）
brew install cmake ninja git
git clone https://github.com/microsoft/vcpkg.git ~/vcpkg
~/vcpkg/bootstrap-vcpkg.sh -disableMetrics
echo 'export VCPKG_ROOT="$HOME/vcpkg"' >> ~/.zshrc
source ~/.zshrc
```

Xcode 本体を使う場合は App Store からインストールし、`sudo xcode-select -s /Applications/Xcode.app/Contents/Developer` を実行してください。`brew install vcpkg` はツール本体のみでポート定義を含まないため、上記のように Git で取得したものを `VCPKG_ROOT` に指定します。

#### ビルド

```bash
bash scripts/build-macos.sh
bash scripts/install-macos.sh
```

生成物は `build/VST3/Release/VST2413P.vst3`、`VST2413R.vst3`、`VST2413S.vst3` です。

DMG を作るには `VERSION=1.0.0 bash scripts/package-release-macos.sh` を実行します。

macOS 実機でビルド、SDK validator の通過、DAW での読み込みと動作を確認済みです。配布する場合は、コード署名と公証を行い、Gatekeeper の動作を確認してください。

## English

The VST3 SDK (MIT licensed) is obtained through [vcpkg](https://vcpkg.io/) manifest mode. The official port omits VSTGUI and the CMake helpers, so the overlay port [`ports/vst3sdk-source`](../ports/vst3sdk-source) installs the full SDK source tree including VSTGUI. The pinned target is VST3 SDK `v3.8.1_build_84`. vcpkg fetches it automatically during CMake configure, so no manual SDK checkout is needed (`-DVST3_SDK_ROOT=...` still overrides it).

Building it yourself is recommended over using the prebuilt binaries. Tool installation commands for each OS are listed below.

### Windows (verified)

Requirements:

- Visual Studio 2026 or Build Tools with “Desktop development with C++”
- CMake 4.2 or newer (required for the Visual Studio 2026 CMake generator)
- vcpkg (`VCPKG_ROOT`)

#### Installing the tools (Chocolatey)

Run in an elevated PowerShell:

```powershell
choco install -y visualstudio2026buildtools --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"
choco install -y cmake --installargs 'ADD_CMAKE_TO_PATH=System'
choco install -y git
```

Clone and bootstrap vcpkg, then set `VCPKG_ROOT` (takes effect in new terminals):

```powershell
git clone https://github.com/microsoft/vcpkg.git C:\vcpkg
C:\vcpkg\bootstrap-vcpkg.bat -disableMetrics
[Environment]::SetEnvironmentVariable('VCPKG_ROOT', 'C:\vcpkg', 'User')
```

#### Building

From **Developer PowerShell for VS 2026**:

```powershell
.\scripts\build-windows.ps1
```

The generated bundles are `build\VST3\Release\VST2413P.vst3`, `VST2413R.vst3`, and `VST2413S.vst3`. Treat every `.vst3` as a complete directory. To create a ZIP that does not contain the SDK:

```powershell
.\scripts\package-release.ps1 -Version 1.0.0
```

### macOS (verified)

Requirements are Xcode or the Xcode Command Line Tools, CMake 3.25 or newer, and vcpkg (`VCPKG_ROOT`). The helper requests a universal binary. With Command Line Tools only, it sets `XCODE_VERSION` automatically so the SDK's Xcode version check passes.

#### Installing the tools (Homebrew)

```bash
xcode-select --install          # Command Line Tools (not needed if full Xcode is installed)
brew install cmake ninja git
git clone https://github.com/microsoft/vcpkg.git ~/vcpkg
~/vcpkg/bootstrap-vcpkg.sh -disableMetrics
echo 'export VCPKG_ROOT="$HOME/vcpkg"' >> ~/.zshrc
source ~/.zshrc
```

To use full Xcode instead, install it from the App Store and run `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer`. `brew install vcpkg` provides only the tool without port definitions, so point `VCPKG_ROOT` at the Git clone above.

#### Building

```bash
bash scripts/build-macos.sh
bash scripts/install-macos.sh
```

The generated bundles are `build/VST3/Release/VST2413P.vst3`, `VST2413R.vst3`, and `VST2413S.vst3`.

To create a DMG, run `VERSION=1.0.0 bash scripts/package-release-macos.sh`.

The build, the SDK validator, and loading and playback in a DAW have been verified on a real Mac. Before distributing a macOS build, sign and notarize it and check Gatekeeper behavior.
