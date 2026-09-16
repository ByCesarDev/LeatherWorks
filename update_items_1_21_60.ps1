$itemsDir = Join-Path $PSScriptRoot "LeatherWorks BP\items"
$files = Get-ChildItem -Path $itemsDir -Filter "*.json"

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # 1. Update format_version
    $content = $content -replace '"format_version":\s*"1\.20\.\d+"', '"format_version": "1.21.60"'
    
    # 2. Modernize category -> menu_category if still using legacy category
    if ($content -match '"category":\s*"items"') {
        $content = $content -replace '"category":\s*"items"', '"menu_category": { "category": "items" }'
    }
    if ($content -match '"category":\s*"equipment"') {
        $content = $content -replace '"category":\s*"equipment"', '"menu_category": { "category": "equipment" }'
    }
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Modernized item: $($file.Name)" -ForegroundColor Green
}
