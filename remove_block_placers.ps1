$itemsDir = Join-Path $PSScriptRoot "LeatherWorks BP\items"
$files = Get-ChildItem -Path $itemsDir -Filter "*.json"

$count = 0
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    if ($content -match "minecraft:block_placer") {
        Remove-Item -Path $file.FullName -Force
        Write-Host "Removed block placer item: $($file.Name)" -ForegroundColor Yellow
        $count++
    }
}

Write-Host "Total block placer items removed: $count" -ForegroundColor Green
