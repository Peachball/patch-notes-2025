extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: JumpComponent
@export var health_component: HealthComponent
@export var fall_damage_component: FallDamageComponent

func _ready() -> void:
	$Timer.start()
	if health_component:
		health_component.died.connect(_on_player_died)
	if fall_damage_component:
		fall_damage_component.fall_damage_dealt.connect(_on_fall_damage_dealt)

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input())
	animation_component.handle_move_animation(input_component.input_horizontal)
	animation_component.handle_jump_animation(jump_component.is_jumping, gravity_component.is_falling)
	fall_damage_component.handle_fall_damage(self, gravity_component, health_component, delta)
	
	move_and_slide()

func _on_player_died() -> void:
	print("Player died!")
	
func _on_fall_damage_dealt(damage_amount: int) -> void:
	print("Took ", damage_amount, " fall damage!")

func _on_timer_timeout() -> void:
	input_component.randomize_controls()
