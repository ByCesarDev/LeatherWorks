$itemsDir = Join-Path $PSScriptRoot "LeatherWorks BP\items"
$packs = @(
    "pack_black", "pack_blue", "pack_brown", "pack_cyan", "pack_gray", "pack_green",
    "pack_light_blue", "pack_lime", "pack_magenta", "pack_orange", "pack_pink",
    "pack_purple", "pack_red", "pack_silver", "pack_yellow", "ender_pack"
)

foreach ($p in $packs) {
    $file = Join-Path $itemsDir "$p.json"
    $id = "lw:$p"
    $tex = "lw_$p"
    $displayNameKey = "item.lw.$p.name"
    
    $json = @"
{
	"format_version": "1.20.0",
	"minecraft:item": {
		"description": {
			"identifier": "$id",
			"menu_category": {
				"category": "equipment"
			}
		},
		"components": {
			"minecraft:display_name": {
				"value": "$displayNameKey"
			},
			"minecraft:icon": {
				"texture": "$tex"
			},
			"minecraft:max_stack_size": 1,
			"minecraft:wearable": {
				"slot": "slot.chest"
			}
		}
	}
}
"@
    Set-Content -Path $file -Value $json -Encoding UTF8
    Write-Host "Updated pack item: $p.json" -ForegroundColor Green
}
