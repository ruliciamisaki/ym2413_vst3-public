[CmdletBinding(SupportsShouldProcess)]
param(
    [ValidateSet('all', 'p', 'r', 's')]
    [string]$Plugin = 'all',
    [ValidateSet('Release', 'Debug')]
    [string]$Configuration = 'Release',
    [string]$BuildDir = (Join-Path $PSScriptRoot '..\build'),
    [string]$Destination = (Join-Path $env:CommonProgramFiles 'VST3')
)

$ErrorActionPreference = 'Stop'
$BuildDir = [IO.Path]::GetFullPath($BuildDir)
$Destination = [IO.Path]::GetFullPath($Destination)
$names = if ($Plugin -eq 'all') { @('VST2413P', 'VST2413R', 'VST2413S') } else { @("VST2413$($Plugin.ToUpperInvariant())") }

foreach ($name in $names) {
    $bundle = Join-Path $BuildDir "VST3\\$Configuration\\$name.vst3"
    if (-not (Test-Path $bundle -PathType Container)) {
        throw "Bundle not found: $bundle. Run scripts/build-windows.ps1 first."
    }
}

if (-not (Test-Path $Destination)) {
    if ($PSCmdlet.ShouldProcess($Destination, 'Create VST3 destination directory')) {
        New-Item -ItemType Directory -Force -Path $Destination | Out-Null
    }
}

foreach ($name in $names) {
    $bundle = Join-Path $BuildDir "VST3\\$Configuration\\$name.vst3"
    if ($PSCmdlet.ShouldProcess($Destination, "Install $name.vst3")) {
        Copy-Item -Recurse -Force -Path $bundle -Destination $Destination
    }
}

Write-Host "Installed to: $Destination"
