extends Node2D

const HEIGHT_GAP := 5
const MAX_DISTANCE := 3 
const NUM_LAYERS := 100
const STARTING_DELAY := 5
const WIDTH_IN_TILES := 15

func _ready() -> void:
	generate_level()
	generate_background()
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

func generate_background():
	const BACKGROUND_EXTENSION := 10
	var noise := FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	var x_min := -BACKGROUND_EXTENSION
	var x_max := WIDTH_IN_TILES + BACKGROUND_EXTENSION
	var y_min := -BACKGROUND_EXTENSION
	var y_max := level_height() + BACKGROUND_EXTENSION
	for x in range(x_min, x_max):
		for y in range(y_min, y_max):
			if x < 0 or y <= 0 or x > WIDTH_IN_TILES or y >= level_height():
				$background.set_cell(
					Vector2i(x, y),
					7,
					Vector2i(2, 2)
				)
				continue
			var noise_value := normalize(
				noise.get_noise_2d(x*10, y*10),
				-1,
				1
			)
			const brick_atlas_coords := [
				Vector2i(12, 3),
				Vector2i(12, 4),
				Vector2i(11, 5),
				Vector2i(11, 6),
				Vector2i(12, 5),
				Vector2i(9, 4),
				Vector2i(9, 5),
				Vector2i(9, 3),
				Vector2i(8, 1),
				Vector2i(8, 2)
			]
			var atlas_coord: Vector2i
			for coord_ind in range(len(brick_atlas_coords)):
				var threshold := (coord_ind + 1.01) / len(brick_atlas_coords)
				if noise_value <= threshold:
					atlas_coord = brick_atlas_coords[coord_ind]
					break
			$background.set_cell(
				Vector2i(x, y),
				7,
				atlas_coord
			)

func normalize(v: float, v_min: float, v_max: float) -> float:
	return (v - v_min) / (v_max - v_min)

func level_height() -> int:
	return HEIGHT_GAP*NUM_LAYERS + STARTING_DELAY

func generate_level() -> void:
	for i in range(NUM_LAYERS):
		var saw_midpoint := randi_range(0, WIDTH_IN_TILES-1)
		var spawn_position := Vector2i(saw_midpoint, i * HEIGHT_GAP + STARTING_DELAY)
		if randi_range(0, 1) == 0:
			spawn_saw(spawn_position)
		else:
			spawn_platform(spawn_position)
	
	for i in range(level_height() + 10):
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

func spawn_platform(position: Vector2i):
	$platforms.set_cell(
		position,
		7,
		Vector2i(7, 9)
	)
	$platforms.set_cell(
		position + Vector2i(1, 0),
		7,
		Vector2i(8, 9)
	)
	$platforms.set_cell(
		position + Vector2i(-1, 0),
		7,
		Vector2i(9, 9)
	)
