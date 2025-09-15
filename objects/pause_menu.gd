extends CanvasLayer

var menu := preload("res://scenes/menu.tscn")
var time_since_start := 0
var pause_delay := 1

func _process(delta: float) -> void:
	time_since_start += delta
	if Input.is_action_just_pressed("pause") and time_since_start > pause_delay:
		resume()

func resume() -> void:
	visible = false
	get_tree().paused = false

func _on_resume_button_pressed() -> void:
	resume()

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(menu)

func _on_visibility_changed() -> void:
	time_since_start = 0
