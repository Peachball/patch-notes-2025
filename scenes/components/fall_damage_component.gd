class_name FallDamageComponent
extends Node

@export_subgroup("Settings")
@export var safe_fall_time: float = 1.0
@export var damage_thresholds: Array[float] = [2.0, 4.0, 6.0]
@export var damage_amounts: Array[int] = [1, 2, 3]

var fall_time: float = 0.0
var was_falling: bool = false

signal fall_damage_dealt(damage_amount: int)

func handle_fall_damage(body: CharacterBody2D, gravity_component: GravityComponent, health_component: HealthComponent, delta: float) -> void:
	if gravity_component.is_falling:
		fall_time += delta
		was_falling = true
	else:
		if was_falling and body.is_on_floor():
			_check_fall_damage(health_component)
		_reset_fall_tracking()

func _check_fall_damage(health_component: HealthComponent) -> void:
	if fall_time <= safe_fall_time:
		return
	
	var damage_to_deal = 0
	for i in range(damage_thresholds.size()):
		if fall_time > damage_thresholds[i]:
			damage_to_deal = damage_amounts[i]
	
	if damage_to_deal > 0:
		health_component.take_damage(damage_to_deal)
		fall_damage_dealt.emit(damage_to_deal) 

func _reset_fall_tracking() -> void:
	fall_time = 0.0
	was_falling = false
