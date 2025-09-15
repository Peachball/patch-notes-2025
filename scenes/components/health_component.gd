class_name HealthComponent
extends Node

@export_subgroup("Settings")
@export var max_health: int = 3
@export var current_health: int = 3

signal health_changed(new_health: int)
signal died()

func _ready() -> void:
	current_health = max_health

func take_damage(amount: int = 1) -> void:
	current_health = max(0, current_health - amount)
	health_changed.emit(current_health)
	$AudioStreamPlayer.play()
	
	if current_health <= 0:
		GameState.last_won = false
		get_tree().change_scene_to_file("res://scenes/end_scene.tscn")

func heal(amount: int = 1) -> void:
	current_health = min(max_health, current_health + amount)
	health_changed.emit(current_health)

func is_alive() -> bool:
	return current_health > 0

func reset_health() -> void:
	current_health = max_health
	health_changed.emit(current_health)
