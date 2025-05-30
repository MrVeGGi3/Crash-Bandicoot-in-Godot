class_name CrashBandicoot
extends CharacterBody3D

##Current state of Crash
@export_group("Crash Properties")
@export var current_state : CrashState
@export var speed : float = 10.0
@export var acceleration : float = 8.0
@export var jump_force : float =  40.0
@export var rotation_speed : float = 12.0
@onready var _skin : Node3D = %CrashAnimations

@export var gravity = -30


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

func _process(delta: float) -> void:
	emit_signal("state_changed", current_state)
	print(current_state)
	
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
	
	if is_on_floor():
		if is_jumping:
			velocity.y += jump_force
			if current_state != CrashState.ATTACKING:
				current_state = CrashState.JUMPING
				
		elif move_direction.length() > 0.1:
				current_state = CrashState.WALKING
		
		elif current_state == CrashState.FALLING:
			current_state = CrashState.FELT
		else:
			if current_state != CrashState.FELT:
				current_state = CrashState.IDLE
	else:
		if velocity.y < - 0.5:
			current_state = CrashState.FALLING
		
	move_and_slide()
	
	if move_direction.length() > 0.2:
		_last_mov_direction = move_direction
	
	var target_angle := Vector3.BACK.signed_angle_to(_last_mov_direction, Vector3.UP)
	_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, rotation_speed * get_physics_process_delta_time())
	
