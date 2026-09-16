$itemsDir = Join-Path $PSScriptRoot "LeatherWorks BP\items"
$files = Get-ChildItem -Path $itemsDir -Filter "*.json"

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # Update format_version from 1.20.0 to 1.20.10
    $content = $content -replace '"format_version":\s*"1\.20\.0"', '"format_version": "1.20.10"'
    
    # Remove minecraft:wearable block if present
    $content = $content -replace ',\s*"minecraft:wearable":\s*\{\s*"slot":\s*"slot\.chest"\s*\}', ''
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Updated format_version to 1.20.10 for: $($file.Name)" -ForegroundColor Green
}
