[CmdletBinding()]
param(
    [string]$Version = '1.0.0',
    [ValidateSet('Release', 'Debug')]
    [string]$Configuration = 'Release',
    [string]$BuildDir = (Join-Path $PSScriptRoot '..\build'),
    [string]$OutputDir = (Join-Path $PSScriptRoot '..\dist')
)

$ErrorActionPreference = 'Stop'
$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$BuildDir = [IO.Path]::GetFullPath($BuildDir)
$OutputDir = [IO.Path]::GetFullPath($OutputDir)
$packageName = "VST2413-$Version-windows-x86_64"
$stage = Join-Path $OutputDir $packageName
$zip = Join-Path $OutputDir "$packageName.zip"

if (Test-Path $stage) { throw "Staging directory already exists: $stage" }
if (Test-Path $zip) { throw "Package already exists: $zip" }

$bundles = @('VST2413P', 'VST2413R', 'VST2413S') | ForEach-Object {
    Join-Path $BuildDir "VST3\\$Configuration\\$_.vst3"
}
foreach ($bundle in $bundles) {
    if (-not (Test-Path $bundle -PathType Container)) { throw "Bundle not found: $bundle" }
}

New-Item -ItemType Directory -Force -Path $stage | Out-Null
foreach ($bundle in $bundles) { Copy-Item -Recurse -Path $bundle -Destination $stage }
Copy-Item -Path (Join-Path $projectRoot 'README.md'), (Join-Path $projectRoot 'LICENSE'), (Join-Path $projectRoot 'ACKNOWLEDGMENTS.md'), (Join-Path $projectRoot 'NOTICE.md'), (Join-Path $projectRoot 'THIRD_PARTY_NOTICES.md') -Destination $stage
Copy-Item -Recurse -Path (Join-Path $projectRoot 'docs') -Destination $stage
Compress-Archive -Path $stage -DestinationPath $zip

Write-Host "Created: $zip"
