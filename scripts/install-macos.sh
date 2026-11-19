#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "$0")/.." && pwd)"
build_dir="${BUILD_DIR:-$project_root/build}"
configuration="${CONFIGURATION:-Release}"
destination="${VST3_DESTINATION:-$HOME/Library/Audio/Plug-Ins/VST3}"
plugin="${1:-all}"

case "$plugin" in
  all) names=(VST2413P VST2413R VST2413S) ;;
  p|r|s) names=("VST2413$(echo "$plugin" | tr prs PRS)") ;;
  *) echo "Usage: $0 [all|p|r|s]" >&2; exit 2 ;;
esac

mkdir -p "$destination"
for name in "${names[@]}"; do
  bundle="$build_dir/VST3/$configuration/$name.vst3"
  [[ -d "$bundle" ]] || { echo "Bundle not found: $bundle" >&2; exit 1; }
  ditto "$bundle" "$destination/$name.vst3"
done

echo "Installed to: $destination"
