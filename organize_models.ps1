$modelsDir = Join-Path $PSScriptRoot "LeatherWorks RP\models"
$blocksDir = Join-Path $modelsDir "blocks"

if (!(Test-Path $blocksDir)) {
    New-Item -ItemType Directory -Path $blocksDir | Out-Null
}

Get-ChildItem -Path $modelsDir -Filter "*.geo.json" | Move-Item -Destination $blocksDir -Force
Write-Host "Moved model files to $blocksDir" -ForegroundColor Green
