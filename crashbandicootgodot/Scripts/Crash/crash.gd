class_name CrashBandicoot
extends CharacterBody3D

##Current state of Crash
@export_group("Crash Properties")
@export var current_state : CrashState
@export var speed : float = 100.0
@export var acceleration : float = 8.0
@export var jump_force : float =  100.0
@export var rotation_speed : float = 12.0
@export var bump_speed : float = -50.0
@export var dash_speed : float = 100.00
@onready var _skin : Node3D = %CrashAnimations

@export var gravity = -120


@export_group("Movement")
var _camera_input_direction := Vector2.ZERO
var _last_mov_direction := Vector3.BACK

@export_group("Camera Control")
@export_range(0.1,1,0.1) var mouse_sens : float = 0.2
@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera : Camera3D = %Camera3D



enum CrashState 
{
	IDLE,
	WALKING,
	JUMPING,
	FALLING,
	FELT,
	DASHING,
	ATTACKING,
	FALLATTACK,
	DIED
}

static var STATE_TO_CONDITION = {
	CrashState.IDLE: "idle",
	CrashState.WALKING: "walk",
	CrashState.JUMPING: "jump",
	CrashState.ATTACKING: "attack",
	CrashState.FALLATTACK: "fall_a",
	CrashState.FALLING: "fall",
	CrashState.DASHING: "dash",
	CrashState.FELT: "felt"
}
##Signal where u send the actual state of the main characther
signal state_changed(state)

func _ready() -> void:
	current_state = CrashState.IDLE
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sens
		
	
func _physics_process(delta: float) -> void:
	_handle_camera_and_movement()
	

func _handle_camera_and_movement():
	_camera_pivot.rotation.x += _camera_input_direction.y * get_physics_process_delta_time()
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
	_camera_pivot.rotation.y = _camera_input_direction.x * get_physics_process_delta_time()
	
	_camera_input_direction = Vector2.ZERO
	
	var raw_input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	
	var move_direction = forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	
	velocity.y += gravity * get_physics_process_delta_time()
	velocity = velocity.move_toward(move_direction * speed, acceleration * get_physics_process_delta_time())
	
	var is_jumping := Input.is_action_just_pressed("jump") 
	var is_attacking := Input.is_action_just_pressed("attack")
	var is_bumping := Input.is_action_just_pressed("bump")
	
	
	if is_on_floor():
		if is_jumping:
			velocity.y += jump_force
			if not is_attacking:
				set_state(CrashState.JUMPING)
			else:
				set_state(CrashState.ATTACKING)
			
		elif move_direction.length() > 0.1 and current_state != CrashState.DASHING:
			set_state(CrashState.WALKING)
			if is_attacking:
				set_state(CrashState.ATTACKING)
			elif is_bumping:
				set_state(CrashState.DASHING)
				velocity = move_direction * dash_speed
			
				
		elif current_state == CrashState.FALLING:
			set_state(CrashState.FELT)
		else:
			if is_attacking:
				set_state(CrashState.ATTACKING)
			else:
				if current_state != CrashState.FELT and current_state != CrashState.DASHING:
					set_state(CrashState.IDLE)
	else:
		if current_state != CrashState.DASHING:
			if velocity.y < - 0.5 and current_state != CrashState.FALLATTACK:
				set_state(CrashState.FALLING)
			elif is_attacking:
				set_state(CrashState.ATTACKING)
			elif is_bumping:
				set_state(CrashState.FALLATTACK)
			
			
		
	move_and_slide()
	
	if move_direction.length() > 0.2:
		_last_mov_direction = move_direction
	
	var target_angle := Vector3.BACK.signed_angle_to(_last_mov_direction, Vector3.UP)
	_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, rotation_speed * get_physics_process_delta_time())
	
func reset_velocity():
	velocity = Vector3.ZERO

func set_state(new_state : CrashState):
	if new_state != current_state:
		current_state = new_state
		emit_signal("state_changed", current_state)
