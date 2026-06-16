Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Lustdew Valley HanHua - Config Menu Install" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

$sdvPath = "C:\Program Files (x86)\Steam\steamapps\common\Stardew Valley"

if (-not (Test-Path -LiteralPath "$sdvPath\Stardew Valley.exe")) {
    Write-Host "[ERROR] Cannot find Stardew Valley at $sdvPath" -ForegroundColor Red
    Write-Host "Please manually copy i18n\zh.json to the original mod's i18n folder." -ForegroundColor Yellow
    pause
    exit 1
}

# Use LiteralPath to handle square brackets [] in folder names
$originalMod = $null
$pathsToCheck = @(
    "$sdvPath\Mods\[CP] Lustdew Valley",
    "$sdvPath\Mods\LUSTDEW VALLEY\[CP] Lustdew Valley"
)

foreach ($p in $pathsToCheck) {
    if (Test-Path -LiteralPath $p) { $originalMod = $p; break }
}

if (-not $originalMod) {
    Write-Host "[ERROR] Cannot find original [CP] Lustdew Valley mod!" -ForegroundColor Red
    Write-Host "Please make sure the original mod is installed." -ForegroundColor Yellow
    Write-Host "Looked in:" -ForegroundColor Gray
    foreach ($p in $pathsToCheck) { Write-Host "  $p" -ForegroundColor Gray }
    pause
    exit 1
}

$ourMod = Split-Path -Parent $MyInvocation.MyCommand.Path
$src = "$ourMod\i18n\zh.json"
$dstDir = "$originalMod\i18n"

if (-not (Test-Path -LiteralPath $dstDir)) { New-Item -ItemType Directory -Path $dstDir -Force | Out-Null }

Copy-Item -LiteralPath $src -Destination "$dstDir\zh.json" -Force

if (Test-Path -LiteralPath "$dstDir\zh.json") {
    Write-Host "[SUCCESS] Config menu translation installed!" -ForegroundColor Green
    Write-Host "Restart the game, Lustdew Valley config menu will show in Chinese." -ForegroundColor Green
} else {
    Write-Host "[FAILED] Copy failed. Try running as Administrator." -ForegroundColor Red
}

pause
