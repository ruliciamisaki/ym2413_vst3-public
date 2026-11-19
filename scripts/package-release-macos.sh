#!/usr/bin/env bash
# Creates a macOS disk image (.dmg) containing the three VST3 bundles, the
# legal notices and docs, and a shortcut to the VST3 plug-in folder so users
# can install by drag & drop.
#
# Usage: VERSION=1.0.0 bash scripts/package-release-macos.sh
set -euo pipefail

project_root="$(cd "$(dirname "$0")/.." && pwd)"
version="${VERSION:-1.0.0}"
configuration="${CONFIGURATION:-Release}"
build_dir="${BUILD_DIR:-$project_root/build}"
output_dir="${OUTPUT_DIR:-$project_root/dist}"

package_name="VST2413-$version-macos-universal"
stage="$output_dir/$package_name"
dmg="$output_dir/$package_name.dmg"

[[ -e "$stage" ]] && { echo "Staging directory already exists: $stage" >&2; exit 1; }
[[ -e "$dmg" ]] && { echo "Package already exists: $dmg" >&2; exit 1; }

bundles=()
for name in VST2413P VST2413R VST2413S; do
  bundle="$build_dir/VST3/$configuration/$name.vst3"
  [[ -d "$bundle" ]] || { echo "Bundle not found: $bundle (run scripts/build-macos.sh first)" >&2; exit 1; }
  archs="$(lipo -archs "$bundle/Contents/MacOS/$name")"
  [[ "$archs" == *x86_64* && "$archs" == *arm64* ]] || { echo "$name is not a universal binary ($archs)" >&2; exit 1; }
  bundles+=("$bundle")
done

mkdir -p "$stage"
for bundle in "${bundles[@]}"; do
  ditto "$bundle" "$stage/$(basename "$bundle")"
done
cp "$project_root"/{README.md,LICENSE,ACKNOWLEDGMENTS.md,NOTICE.md,THIRD_PARTY_NOTICES.md} "$stage/"
ditto "$project_root/docs" "$stage/docs"

# Drag & drop target. A symlink cannot expand "~", so the shared plug-in folder
# /Library/Audio/Plug-Ins/VST3 is linked (Finder asks for an administrator
# password when copying there). For a per-user install, see docs/INSTALL.md.
ln -s /Library/Audio/Plug-Ins/VST3 "$stage/VST3"

hdiutil create -volname "VST2413 $version" -srcfolder "$stage" -fs HFS+ -format UDZO -ov "$dmg" >/dev/null
rm -rf "$stage"

echo "Created: $dmg"
