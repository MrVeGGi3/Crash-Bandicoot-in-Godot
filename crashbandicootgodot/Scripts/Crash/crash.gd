class_name CrashBandicoot
extends CharacterBody3D

##Current state of Crash
@export var current_state : CrashState
@export var speed : float = 10.0
@export var jump_force : float = - 10.0

enum CrashState 
{
	IDLE,
	WALKING,
	JUMPING,
	FALLING,
	DASHING,
	ATTACKING,
	FALLATTACK,
	DIED
}

##Signal where u send the actual state of the main characther
signal state_changed(state)

func _ready() -> void:
	current_state = CrashState.IDLE
	
func _process(delta: float) -> void:
	emit_signal("state_changed", current_state)
	
func _physics_process(delta: float) -> void:
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_dir = input_dir.normalized()
	
	var direction = Vector3(input_dir.x, 0, input_dir.y)
	
	if direction.length() > 0:
		current_state = CrashState.WALKING
		direction = global_transform.basis * direction
		direction.y = 0
		direction = direction.normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		look_at(global_transform.origin + direction, Vector3.UP)
	
	else:
		current_state = CrashState.IDLE
		velocity.x = 0
		velocity.z = 0
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		current_state = CrashState.FALLING
	else:
		if Input.is_action_just_pressed("jump"):
			current_state = CrashState.JUMPING
			velocity.y = jump_force
			
		elif velocity.y > 0: 
			current_state = CrashState.FALLING
	
	move_and_slide()
	
