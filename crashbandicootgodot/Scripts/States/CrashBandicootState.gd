extends CharacterBody3D
class_name CrashBandicootState

@export_group("Crash Properties")
@export var speed : float = 100.0
@export var acceleration : float = 20.0
@export var jump_force : float = 50.0
@export var dash_speed : float = 50.0
@export var bump_speed : float = -50.0
@export var bump_impulse : float = 50.0
@export var rotation_speed : float = 12.0
@export var gravity : float = -120.0



@onready var crash_animation_tree: AnimationTree = $CrashAnimationTree
@onready var crash_animation : AnimationPlayer = %CrashAnimationPlayer
@onready var _skin : Node3D = %CrashAnimations


@export_group("Movement")
var _camera_input_direction := Vector2.ZERO
var _last_mov_direction := Vector3.BACK

@export_group("Camera Control")
@export_range(0.1,1,0.1) var mouse_sens : float = 0.2
@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera : Camera3D = %Camera3D

var input_direction : Vector2 = Vector2.ZERO

var states = {}
var current_state : State

var conditions = ["idle", "walk", "jump", "dash", "fall", "fall_a", "felt", "attack"]

@export_group("Box Colliding Manager")
var collider : String
var all_checking_states
@export var is_colliding_with_boxes : bool = false

func _ready() -> void:
	_load_states()
	change_state("Idle")

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
	current_state.physics_update(delta)

func _process(delta: float) -> void:
	current_state.update(delta)
	handle_camera()

func _load_states() -> void:
	states["Idle"] = preload("res://Scripts/States/Idle.gd").new()
	states["Walking"] = preload("res://Scripts/States/Walking.gd").new()
	states["Jumping"] = preload("res://Scripts/States/Jumping.gd").new()
	states["Falling"] = preload("res://Scripts/States/Failling.gd").new()
	states["Attacking"] =preload("res://Scripts/States/Attacking.gd").new()
	states["Dash"] = preload("res://Scripts/States/Dash.gd").new()
	states["Felt"] = preload("res://Scripts/States/Felt.gd").new()
	states["FallAttack"] = preload("res://Scripts/States/FallAttack.gd").new()

	for state in states.values():
		state.char_owner = self
		add_child(state) 

func change_state(state_name: String) -> void:
	if current_state != null:
		current_state.exit()
	current_state = states[state_name]
	current_state.enter()

## Helpers para estados
func is_moving() -> bool:
	return get_input_direction().length() > 0.2

func is_jumping() -> bool:
	return Input.is_action_just_pressed("jump")

func is_attacking() -> bool:
	return Input.is_action_just_pressed("attack")

func is_dashing() -> bool:
	return Input.is_action_just_pressed("bump")

func get_input_direction() -> Vector3:
	var raw_input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	var dir = forward * raw_input.y + right * raw_input.x
	dir.y = 0.0
	dir = dir.normalized()
	return dir

func get_dash_direction() -> Vector3:
	return get_input_direction()

func move_character() -> void:
	camera_preset()
	
	var direction = get_input_direction()
	velocity = velocity.move_toward(direction * speed, acceleration * get_physics_process_delta_time())
	move_and_slide()

	handle_camera()

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()

func play_animation(anim: String) -> void:
	crash_animation.play(anim)

func is_animation_playing() -> bool:
	return crash_animation.is_playing()

func camera_preset():
	_camera_pivot.rotation.x += _camera_input_direction.y * get_physics_process_delta_time()
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
	_camera_pivot.rotation.y = _camera_input_direction.x * get_physics_process_delta_time()
	
	_camera_input_direction = Vector2.ZERO
	
func handle_camera():
	if is_moving():
		_last_mov_direction = get_input_direction()
	
	var target_angle := Vector3.BACK.signed_angle_to(_last_mov_direction, Vector3.UP)
	_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, rotation_speed * get_physics_process_delta_time())

func jump():
	velocity.y += jump_force

func bump_impulse_jump():
	velocity.y += bump_impulse

func set_walk_blend_value():
	crash_animation_tree["parameters/WalkBlend/blend_amount"] = get_input_direction().length()
	
func reset_velocity():
	velocity = Vector3.ZERO
	
func set_tree_transition_request(transition):
	crash_animation_tree["parameters/Transition/transition_request"] = transition


func check_box_collision_state() -> bool:
	var is_bumping_state = true if current_state == states["FallAttack"] else false
	var is_dashing_state = true if current_state == states["Dash"] else false
	var is_falling_state = true if current_state == states["Falling"] else false
	var is_attacking_state = true if current_state == states["Attacking"] else false
	
	match collider:
		"NormalBox":
			all_checking_states = ( 
					is_bumping_state or 
					is_dashing_state or 
					is_falling_state or 
					is_attacking_state
			)
		"ChainBox":
			all_checking_states = (
				is_bumping_state
			)
	

	return all_checking_states
					
				
					
func is_colliding_box():
	return is_colliding_with_boxes
					
