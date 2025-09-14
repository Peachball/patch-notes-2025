extends Node2D

const platform_scn := preload("res://objects/platform.tscn")

func _ready() -> void:
	generate_level()

func generate_level() -> void:
	const HEIGHT_GAP := 5
	const MAX_DISTANCE := 3
	const NUM_LAYERS := 100
	const STARTING_DELAY := 5
	const WIDTH_IN_TILES := 15
	
	for i in range(NUM_LAYERS):
		var saw_midpoint := randi_range(0, WIDTH_IN_TILES-1)
		spawn_saw(Vector2i(saw_midpoint, i * HEIGHT_GAP + STARTING_DELAY))
	
	for i in range(NUM_LAYERS * HEIGHT_GAP + STARTING_DELAY + 10):
		$platforms.set_cell(
			Vector2i(-1, i),
			7,
			Vector2i(3, 2)
		)
		$platforms.set_cell(
			Vector2i(WIDTH_IN_TILES + 1, i),
			7,
			Vector2i(1, 2)
		)
	
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
