extends Node2D

const platform_scn := preload("res://objects/platform.tscn")

func _ready() -> void:
	generate_level()

func generate_level() -> void:
	const HEIGHT_GAP := 5
	const MAX_DISTANCE := 3
	const NUM_LAYERS := 20
	const STARTING_DELAY := 5
	
	for i in range(NUM_LAYERS):
		var saw_midpoint := randi_range(0, 19)
		spawn_saw(Vector2i(saw_midpoint, i * HEIGHT_GAP + STARTING_DELAY))
	
func spawn_saw(position: Vector2i):
	const ATLAS_SAW_LEFT := Vector2i(10, 15)
	for i in range(3):
		$platforms.set_cell(
			position + Vector2i(i, 0),
			7,
			ATLAS_SAW_LEFT + Vector2i(i, 0)
		)
		$platforms.set_cell(
			position + Vector2i(i, 0) + Vector2i(0, 1),
			7,
			Vector2i(2, 5)
		)
