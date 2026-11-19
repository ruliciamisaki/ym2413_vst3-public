# インストール / Installation

![VST Compatible](assets/VST_Compatible_Logo_Steinberg_with_TM.png)

## 日本語

### Windows（検証済み）

1. `VST2413-*-windows-x86_64.zip` を展開します。
2. `VST2413P.vst3`、`VST2413R.vst3`、`VST2413S.vst3` を、**フォルダーのまま**次のいずれかへコピーします。
   - 全ユーザー: `C:\Program Files\Common Files\VST3\`
   - 現在のユーザーのみ: `%LOCALAPPDATA%\Programs\Common\VST3\`
3. Cubase Pro 13 の **Studio > VST Plug-in Manager** を開き、再スキャンします。
4. インストゥルメントトラックへ VST2413P / R / S を追加します。

管理者権限の PowerShell なら、ビルド済みの状態で次のコマンドでも入れられます。

```powershell
.\scripts\install-windows.ps1
```

ユーザー専用ディレクトリへ入れる例はこれです。

```powershell
.\scripts\install-windows.ps1 -Destination "$env:LOCALAPPDATA\Programs\Common\VST3"
```

プラグインを削除する場合は、インストール先の対応する `.vst3` フォルダーを閉じた Cubase の状態で削除します。Cubase が読み込み中の DLL だけを削除しないでください。

### macOS（検証済み）

Intel / Apple Silicon の universal binary として、macOS 実機でのビルドと DAW での読み込み・動作を確認済みです。ビルド手順は [BUILD.md](BUILD.md) を参照してください。

DMG を開き、`.vst3` を同梱の `VST3` フォルダー（`/Library/Audio/Plug-Ins/VST3`、管理者パスワードが必要）へドラッグします。自分のユーザーだけに入れる場合は `~/Library/Audio/Plug-Ins/VST3/` へコピーしてください。

通常のユーザー別配置先は `~/Library/Audio/Plug-Ins/VST3/` です。全ユーザー用の `/Library/Audio/Plug-Ins/VST3/` は管理者権限が必要です。> **注意:** macOS 版はコード署名・公証を行っていません。macOS のセキュリティ設定（Gatekeeper）により読み込みを拒否される場合は、配置後に次のコマンドで隔離属性を外してください。
>
> ```bash
> xattr -dr com.apple.quarantine ~/Library/Audio/Plug-Ins/VST3/VST2413*.vst3
> ```

## English

### Windows (verified)

1. Extract `VST2413-*-windows-x86_64.zip`.
2. Copy `VST2413P.vst3`, `VST2413R.vst3`, and `VST2413S.vst3` as complete **folders** to one of these locations.
   - All users: `C:\Program Files\Common Files\VST3\`
   - Current user: `%LOCALAPPDATA%\Programs\Common\VST3\`
3. Open **Studio > VST Plug-in Manager** in Cubase Pro 13 and rescan.
4. Add VST2413P / R / S to an instrument track.

From an elevated PowerShell, after building, installation can also be performed with:

```powershell
.\scripts\install-windows.ps1
```

For a per-user installation:

```powershell
.\scripts\install-windows.ps1 -Destination "$env:LOCALAPPDATA\Programs\Common\VST3"
```

To uninstall, close Cubase and remove the corresponding `.vst3` directory from the chosen location. Do not remove only a DLL while Cubase has loaded it.

### macOS (verified)

Building a universal Intel / Apple Silicon binary and loading and playing it in a DAW have been verified on a real Mac. See [BUILD.md](BUILD.md) for build steps.

Open the DMG and drag the `.vst3` bundles onto the included `VST3` folder (`/Library/Audio/Plug-Ins/VST3`, requires an administrator password). To install for your user only, copy them to `~/Library/Audio/Plug-Ins/VST3/` instead.

The usual per-user location is `~/Library/Audio/Plug-Ins/VST3/`. `/Library/Audio/Plug-Ins/VST3/` is a system-wide location requiring administrator privileges. > **Note:** The macOS build is not code-signed or notarized. If macOS security (Gatekeeper) refuses to load it, remove the quarantine attribute after installing:
>
> ```bash
> xattr -dr com.apple.quarantine ~/Library/Audio/Plug-Ins/VST3/VST2413*.vst3
> ```
