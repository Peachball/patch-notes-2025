extends Node2D

const platform_scn := preload("res://objects/platform.tscn")

func _ready() -> void:
	generate_level()
	setup_player_tracking()

func setup_player_tracking() -> void:
	var player = $Player
	if player and $Player/HealthComponent:
		$Player/HealthComponent.health_changed.connect(_on_player_health_changed)
		$Player/HealthComponent.died.connect(_on_player_died)
	
	if player and player.get_node("Timer"):
		player.get_node("Timer").timeout.connect(_on_controls_scrambled)

func _on_player_health_changed(new_health: int) -> void:
	print("Player health: ", new_health)

func _on_player_died() -> void:
	print("Level: Player has died!")

func _on_controls_scrambled() -> void:
	print("Level: Controls scrambled!")

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
