#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "$0")/.." && pwd)"
build_dir="${BUILD_DIR:-$project_root/build}"
configuration="${CONFIGURATION:-Release}"

command -v cmake >/dev/null || { echo "CMake 3.25 or newer is required." >&2; exit 1; }

if [[ -z "${VCPKG_ROOT:-}" ]]; then
  if [[ -f "$HOME/vcpkg/scripts/buildsystems/vcpkg.cmake" ]]; then
    export VCPKG_ROOT="$HOME/vcpkg"
  else
    echo "VCPKG_ROOT is not set. Install vcpkg and export VCPKG_ROOT." >&2
    exit 1
  fi
fi

# The VST3 SDK probes the Xcode version via xcodebuild, which only exists with
# a full Xcode install. With Command Line Tools only, provide a version so the
# SDK's check passes (the actual build uses the CLT clang toolchain).
extra_args=()
if ! xcodebuild -version >/dev/null 2>&1; then
  export XCODE_VERSION="${XCODE_VERSION:-16.0}"
  extra_args+=("-DXCODE_VERSION=$XCODE_VERSION")
  echo "Xcode not found; building with Command Line Tools (XCODE_VERSION=$XCODE_VERSION)."
fi

cmake -S "$project_root" -B "$build_dir" \
  -DCMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake" \
  -DCMAKE_BUILD_TYPE="$configuration" \
  -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
  ${extra_args[@]+"${extra_args[@]}"}
cmake --build "$build_dir" --config "$configuration" --target vst2413p vst2413r vst2413s

echo "Built bundles: $build_dir/VST3/$configuration"
