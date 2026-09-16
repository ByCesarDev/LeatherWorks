$bpBlocksDir = Join-Path $PSScriptRoot "LeatherWorks BP\blocks"
if (!(Test-Path $bpBlocksDir)) {
    New-Item -ItemType Directory -Path $bpBlocksDir | Out-Null
}

$woods = @("oak", "spruce", "birch", "jungle", "acacia", "darkoak")

# 1. Debarked Logs (Full Block Cube)
foreach ($w in $woods) {
    $id = "lw:debarked_log_$w"
    $file = Join-Path $bpBlocksDir "debarked_log_$w.json"
    $json = @"
{
	"format_version": "1.21.60",
	"minecraft:block": {
		"description": {
			"identifier": "$id",
			"menu_category": {
				"category": "nature"
			}
		},
		"components": {
			"minecraft:geometry": {
				"identifier": "minecraft:geometry.full_block"
			},
			"minecraft:material_instances": {
				"*": {
					"texture": "lw_debarked_log_${w}_side",
					"render_method": "opaque"
				},
				"up": {
					"texture": "lw_debarked_log_${w}_top",
					"render_method": "opaque"
				},
				"down": {
					"texture": "lw_debarked_log_${w}_top",
					"render_method": "opaque"
				}
			},
			"minecraft:destructible_by_mining": {
				"seconds_to_destroy": 2.0
			},
			"minecraft:flammable": {
				"catch_chance_modifier": 5,
				"destroy_chance_modifier": 5
			}
		}
	}
}
"@
    Set-Content -Path $file -Value $json -Encoding UTF8
}

$directionalPermutations = @"
		"permutations": [
			{
				"condition": "q.block_state('minecraft:cardinal_direction') == 'north'",
				"components": {
					"minecraft:transformation": {
						"rotation": [0, 0, 0]
					}
				}
			},
			{
				"condition": "q.block_state('minecraft:cardinal_direction') == 'east'",
				"components": {
					"minecraft:transformation": {
						"rotation": [0, 90, 0]
					}
				}
			},
			{
				"condition": "q.block_state('minecraft:cardinal_direction') == 'south'",
				"components": {
					"minecraft:transformation": {
						"rotation": [0, 180, 0]
					}
				}
			},
			{
				"condition": "q.block_state('minecraft:cardinal_direction') == 'west'",
				"components": {
					"minecraft:transformation": {
						"rotation": [0, 270, 0]
					}
				}
			}
		],
"@

# 2. Barrels
foreach ($w in $woods) {
    $id = "lw:barrel_$w"
    $file = Join-Path $bpBlocksDir "barrel_$w.json"
    $json = @"
{
	"format_version": "1.21.60",
	"minecraft:block": {
		"description": {
			"identifier": "$id",
			"menu_category": {
				"category": "items"
			},
			"traits": {
				"minecraft:placement_direction": {
					"enabled_states": [
						"minecraft:cardinal_direction"
					],
					"y_rotation_offset": 180
				}
			}
		},
$directionalPermutations
		"components": {
			"minecraft:geometry": {
				"identifier": "geometry.barrel_empty"
			},
			"minecraft:material_instances": {
				"*": {
					"texture": "lw_barrel_${w}_side",
					"render_method": "opaque"
				},
				"up": {
					"texture": "lw_barrel_${w}_top",
					"render_method": "opaque"
				},
				"down": {
					"texture": "lw_barrel_${w}_top",
					"render_method": "opaque"
				}
			},
			"minecraft:collision_box": {
				"origin": [-8, 0, -8],
				"size": [16, 16, 16]
			},
			"minecraft:selection_box": {
				"origin": [-8, 0, -8],
				"size": [16, 16, 16]
			},
			"minecraft:destructible_by_mining": {
				"seconds_to_destroy": 2.5
			}
		}
	}
}
"@
    Set-Content -Path $file -Value $json -Encoding UTF8
}

# 3. Sealed Barrels
foreach ($w in $woods) {
    $id = "lw:sealed_barrel_$w"
    $file = Join-Path $bpBlocksDir "sealed_barrel_$w.json"
    $json = @"
{
	"format_version": "1.21.60",
	"minecraft:block": {
		"description": {
			"identifier": "$id",
			"menu_category": {
				"category": "items"
			},
			"traits": {
				"minecraft:placement_direction": {
					"enabled_states": [
						"minecraft:cardinal_direction"
					],
					"y_rotation_offset": 180
				}
			}
		},
$directionalPermutations
		"components": {
			"minecraft:geometry": {
				"identifier": "geometry.barrel_empty"
			},
			"minecraft:material_instances": {
				"*": {
					"texture": "lw_barrel_${w}_side",
					"render_method": "opaque"
				},
				"up": {
					"texture": "lw_barrel_${w}_top",
					"render_method": "opaque"
				},
				"down": {
					"texture": "lw_barrel_${w}_top",
					"render_method": "opaque"
				}
			},
			"minecraft:collision_box": {
				"origin": [-8, 0, -8],
				"size": [16, 16, 16]
			},
			"minecraft:selection_box": {
				"origin": [-8, 0, -8],
				"size": [16, 16, 16]
			},
			"minecraft:destructible_by_mining": {
				"seconds_to_destroy": 2.5
			}
		}
	}
}
"@
    Set-Content -Path $file -Value $json -Encoding UTF8
}

# 4. Drying Racks
foreach ($w in $woods) {
    $id = "lw:drying_rack_$w"
    $file = Join-Path $bpBlocksDir "drying_rack_$w.json"
    $json = @"
{
	"format_version": "1.21.60",
	"minecraft:block": {
		"description": {
			"identifier": "$id",
			"menu_category": {
				"category": "items"
			},
			"traits": {
				"minecraft:placement_direction": {
					"enabled_states": [
						"minecraft:cardinal_direction"
					],
					"y_rotation_offset": 180
				}
			}
		},
$directionalPermutations
		"components": {
			"minecraft:geometry": {
				"identifier": "geometry.rack_side"
			},
			"minecraft:material_instances": {
				"*": {
					"texture": "lw_drying_rack_$w",
					"render_method": "alpha_test"
				}
			},
			"minecraft:collision_box": {
				"origin": [-8, 12, 4],
				"size": [16, 4, 4]
			},
			"minecraft:selection_box": {
				"origin": [-8, 12, 4],
				"size": [16, 4, 4]
			},
			"minecraft:destructible_by_mining": {
				"seconds_to_destroy": 1.5
			}
		}
	}
}
"@
    Set-Content -Path $file -Value $json -Encoding UTF8
}

# 5. Leather Trunks
$trunks = @(
    "", "_black", "_blue", "_cyan", "_gray", "_green", "_light_blue",
    "_lime", "_magenta", "_orange", "_pink", "_purple", "_red", "_silver", "_yellow"
)

foreach ($t in $trunks) {
    $id = "lw:leather_trunk$t"
    $fileName = "leather_trunk$t.json"
    $file = Join-Path $bpBlocksDir $fileName
    $tex = "lw_leather_trunk$t"
    $json = @"
{
	"format_version": "1.21.60",
	"minecraft:block": {
		"description": {
			"identifier": "$id",
			"menu_category": {
				"category": "items"
			},
			"traits": {
				"minecraft:placement_direction": {
					"enabled_states": [
						"minecraft:cardinal_direction"
					],
					"y_rotation_offset": 180
				}
			}
		},
$directionalPermutations
		"components": {
			"minecraft:geometry": {
				"identifier": "geometry.leather_trunk"
			},
			"minecraft:material_instances": {
				"*": {
					"texture": "$tex",
					"render_method": "opaque"
				}
			},
			"minecraft:collision_box": {
				"origin": [-7, 0, -7],
				"size": [14, 14, 14]
			},
			"minecraft:selection_box": {
				"origin": [-7, 0, -7],
				"size": [14, 14, 14]
			},
			"minecraft:destructible_by_mining": {
				"seconds_to_destroy": 2.5
			}
		}
	}
}
"@
    Set-Content -Path $file -Value $json -Encoding UTF8
}

Write-Host "Generated 39 block files with cardinal placement directions" -ForegroundColor Green
