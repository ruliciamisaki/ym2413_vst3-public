[CmdletBinding()]
param(
    [ValidateSet('Release', 'Debug')]
    [string]$Configuration = 'Release',
    [string]$BuildDir = (Join-Path $PSScriptRoot '..\build'),
    [string]$VcpkgRoot = $env:VCPKG_ROOT
)

$ErrorActionPreference = 'Stop'
$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$BuildDir = [IO.Path]::GetFullPath($BuildDir)

if (-not (Get-Command cmake -ErrorAction SilentlyContinue)) {
    throw 'CMake 4.2 or newer is required. Install it, then run this script from a VS 2026 Developer PowerShell.'
}
$cmakeVersionOutput = & cmake --version
if ($LASTEXITCODE -ne 0 -or $cmakeVersionOutput[0] -notmatch '^cmake version (?<version>\d+\.\d+(?:\.\d+)?)$') {
    throw 'Unable to determine the CMake version.'
}
if ([version]$Matches.version -lt [version]'4.2') {
    throw 'CMake 4.2 or newer is required for the Visual Studio 2026 generator.'
}
if (-not $VcpkgRoot -or -not (Test-Path (Join-Path $VcpkgRoot 'scripts\buildsystems\vcpkg.cmake'))) {
    throw 'vcpkg was not found. Set VCPKG_ROOT or pass -VcpkgRoot.'
}

$toolchain = Join-Path $VcpkgRoot 'scripts\buildsystems\vcpkg.cmake'
& cmake -S $projectRoot -B $BuildDir -G 'Visual Studio 18 2026' -A x64 "-DCMAKE_TOOLCHAIN_FILE=$toolchain" -DVCPKG_TARGET_TRIPLET=x64-windows
if ($LASTEXITCODE -ne 0) { throw 'CMake configure failed.' }
& cmake --build $BuildDir --config $Configuration --target vst2413p vst2413r vst2413s
if ($LASTEXITCODE -ne 0) { throw 'Build failed.' }

Write-Host "Built bundles: $(Join-Path $BuildDir "VST3\\$Configuration")"
