class_name InputComponent
extends Node

var input_horizontal: float = 0.0
var control_mappings: Dictionary = {
	"move_left": "move_left",
	"move_right": "move_right",
	"jump": "jump"
}
var controls_scrambled: bool = false

func _process(delta: float) -> void:
	input_horizontal = Input.get_axis(control_mappings["move_left"], control_mappings["move_right"])
	
func get_jump_input() -> bool:
	return Input.is_action_just_pressed(control_mappings["jump"])

func randomize_controls() -> void:
	var mappings = ["move_left", "move_right", "jump"]
	mappings.shuffle()
	
	control_mappings["move_left"] = mappings[0]
	control_mappings["move_right"] = mappings[1]
	control_mappings["jump"] = mappings[2]
	
	controls_scrambled = true
	print("Controls scrambled!")

func reset_controls() -> void:
	control_mappings["move_left"] = "move_left"
	control_mappings["move_right"] = "move_right"
	control_mappings["jump"] = "jump"
	
	controls_scrambled = false
	print("Controls reset!")
