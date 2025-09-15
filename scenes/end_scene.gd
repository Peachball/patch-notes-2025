extends Node2D

func _ready() -> void:
	set_win_status(GameState.last_won)

func set_win_status(is_win: bool) -> void:
	$winLabel.visible = is_win
	$loseLabel.visible = !is_win

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://objects/level.tscn")
