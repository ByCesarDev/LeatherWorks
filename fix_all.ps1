$bpDir = Join-Path $PSScriptRoot "LeatherWorks BP"
$rpDir = Join-Path $PSScriptRoot "LeatherWorks RP"
$blocksDir = Join-Path $bpDir "blocks"
$itemsDir = Join-Path $bpDir "items"
$catalogDir = Join-Path $bpDir "item_catalog"

# 1. Remove the 6 bark block files
$barkBlocks = @("oak_bark.json", "spruce_bark.json", "birch_bark.json", "jungle_bark.json", "acacia_bark.json", "darkoak_bark.json")
foreach ($b in $barkBlocks) {
    $p = Join-Path $blocksDir $b
    if (Test-Path $p) {
        Remove-Item -Path $p -Force
        Write-Host "Removed bark block: $b" -ForegroundColor Yellow
    }
}

# 2. Fix all 45 item JSON files
$itemFiles = Get-ChildItem -Path $itemsDir -Filter "*.json"
foreach ($f in $itemFiles) {
    $name = $f.BaseName
    $id = "lw:$name"
    $tex = "lw_$name"
    $displayNameKey = "item.lw.$name.name"
    
    $cat = "items"
    if ($name -like "pack_*" -or $name -eq "ender_pack" -or $name -like "broken_leather_*" -or $name -eq "repair_kit") {
        $cat = "equipment"
    }
    
    $maxStack = 64
    if ($name -like "pack_*" -or $name -eq "ender_pack" -or $name -like "broken_leather_*") {
        $maxStack = 1
    } elseif ($name -eq "repair_kit") {
        $maxStack = 16
    }
    
    $json = @"
{
	"format_version": "1.20.10",
	"minecraft:item": {
		"description": {
			"identifier": "$id",
			"menu_category": {
				"category": "$cat"
			}
		},
		"components": {
			"minecraft:display_name": {
				"value": "$displayNameKey"
			},
			"minecraft:icon": "$tex",
			"minecraft:max_stack_size": $maxStack
		}
	}
}
"@
    Set-Content -Path $f.FullName -Value $json -Encoding UTF8
    Write-Host "Fixed item: $($f.Name)" -ForegroundColor Green
}

# 3. Create fixed crafting_item_catalog.json with plural minecraft:crafting_items_catalog
if (!(Test-Path $catalogDir)) {
    New-Item -ItemType Directory -Path $catalogDir | Out-Null
}

$catalogFile = Join-Path $catalogDir "crafting_item_catalog.json"
$catalogJson = @"
{
	"format_version": "1.20.10",
	"minecraft:crafting_items_catalog": {
		"categories": [
			{
				"category": "construction",
				"groups": [
					{
						"icon": "lw:debarked_log_oak",
						"name": "minecraft:itemGroup.name.log",
						"items": [
							"lw:debarked_log_oak",
							"lw:debarked_log_spruce",
							"lw:debarked_log_birch",
							"lw:debarked_log_jungle",
							"lw:debarked_log_acacia",
							"lw:debarked_log_darkoak"
						]
					}
				]
			},
			{
				"category": "items",
				"groups": [
					{
						"icon": "lw:barrel_oak",
						"name": "minecraft:itemGroup.name.chest",
						"items": [
							"lw:barrel_oak",
							"lw:barrel_spruce",
							"lw:barrel_birch",
							"lw:barrel_jungle",
							"lw:barrel_acacia",
							"lw:barrel_darkoak",
							"lw:sealed_barrel_oak",
							"lw:sealed_barrel_spruce",
							"lw:sealed_barrel_birch",
							"lw:sealed_barrel_jungle",
							"lw:sealed_barrel_acacia",
							"lw:sealed_barrel_darkoak",
							"lw:leather_trunk",
							"lw:leather_trunk_red",
							"lw:leather_trunk_orange",
							"lw:leather_trunk_yellow",
							"lw:leather_trunk_lime",
							"lw:leather_trunk_green",
							"lw:leather_trunk_cyan",
							"lw:leather_trunk_light_blue",
							"lw:leather_trunk_blue",
							"lw:leather_trunk_purple",
							"lw:leather_trunk_magenta",
							"lw:leather_trunk_pink",
							"lw:leather_trunk_gray",
							"lw:leather_trunk_silver",
							"lw:leather_trunk_black"
						]
					},
					{
						"icon": "lw:drying_rack_oak",
						"name": "lw:stations",
						"items": [
							"lw:drying_rack_oak",
							"lw:drying_rack_spruce",
							"lw:drying_rack_birch",
							"lw:drying_rack_jungle",
							"lw:drying_rack_acacia",
							"lw:drying_rack_darkoak"
						]
					},
					{
						"icon": "lw:rawhide_cow",
						"name": "lw:leatherworking_materials",
						"items": [
							"lw:rawhide_cow",
							"lw:rawhide_pig",
							"lw:rawhide_horse",
							"lw:rawhide_wolf",
							"lw:rawhide_polarbear",
							"lw:rawhide_mooshroom",
							"lw:rawhide_llama",
							"lw:rawhide_mule",
							"lw:rawhide_donkey",
							"lw:rawhide_deer",
							"lw:rawhide_boar",
							"lw:bark_oak",
							"lw:bark_spruce",
							"lw:bark_birch",
							"lw:bark_jungle",
							"lw:bark_acacia",
							"lw:bark_darkoak",
							"lw:crafting_leather_scraped",
							"lw:crafting_leather_washed",
							"lw:crafting_leather_soaked",
							"lw:tannin_ball",
							"lw:tannin_bottle",
							"lw:leather_sheet",
							"lw:leather_strip"
						]
					}
				]
			},
			{
				"category": "equipment",
				"groups": [
					{
						"icon": "lw:pack_brown",
						"name": "lw:packs",
						"items": [
							"lw:pack_brown",
							"lw:pack_red",
							"lw:pack_orange",
							"lw:pack_yellow",
							"lw:pack_lime",
							"lw:pack_green",
							"lw:pack_cyan",
							"lw:pack_light_blue",
							"lw:pack_blue",
							"lw:pack_purple",
							"lw:pack_magenta",
							"lw:pack_pink",
							"lw:pack_silver",
							"lw:pack_gray",
							"lw:pack_black",
							"lw:ender_pack"
						]
					},
					{
						"icon": "lw:repair_kit",
						"name": "lw:leather_repair",
						"items": [
							"lw:repair_kit",
							"lw:broken_leather_helmet",
							"lw:broken_leather_chestplate",
							"lw:broken_leather_leggings",
							"lw:broken_leather_boots"
						]
					}
				]
			}
		]
	}
}
"@
Set-Content -Path $catalogFile -Value $catalogJson -Encoding UTF8
Write-Host "Created fixed crafting_item_catalog.json" -ForegroundColor Green
