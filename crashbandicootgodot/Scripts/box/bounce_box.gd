class_name BounceBox
extends Box

@export var bounce_count : int = 3
@export var body_velocity_up : float = 80.0
@export var body_velocity_down : float = -150.0
@onready var jump_box_fracture: Node3D = $JumpBoxFracture

@onready var upper_area_3d: Area3D = $UpperArea3D
@onready var low_area_3d: Area3D = $LowArea3D




func _on_upper_area_3d_body_entered(body: CrashBandicootState) -> void:
	body.collider = "BounceBoxUP"
	if body.check_box_collision_state():
		bounce_count -= 1
		body.velocity.y += body_velocity_up
		status_ui.play_fruit_animation()
		destroy_jump_box()

func _on_low_area_3d_body_entered(body: CrashBandicootState) -> void:
	body.collider = "BounceBoxDOWN"
	if body.check_box_collision_state():
		bounce_count -= 1
		body.velocity.y += body_velocity_down
		status_ui.play_fruit_animation()
		destroy_jump_box()

func destroy_jump_box():
	if bounce_count < 1:
		add_rb_in_tree(jump_box_fracture)
		upper_area_3d.call_deferred("set_disable_mode", true)
		low_area_3d.call_deferred("set_disable_mode", true)
		await get_tree().create_timer(0.5).timeout
		queue_free()
	
func explode():
	if has_exploded:
		return
	add_rb_in_tree(jump_box_fracture)
	await get_tree().create_timer(0.5).timeout
	queue_free()
