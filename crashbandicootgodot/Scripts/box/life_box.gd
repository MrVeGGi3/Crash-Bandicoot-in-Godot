class_name LifeBox
extends Box

@onready var area_3d_collision_shape: CollisionShape3D = $Area3D/Area3DCollisionShape
@onready var static_body_collision_shape: CollisionShape3D = $StaticBody3D/StaticBodyCollisionShape
@onready var destruction_timer: Timer = $DestructionTimer

func _ready() -> void:
	type_box_name = "LifeBox"
	box_fracture = $LifeBoxFractured
	
func _on_area_3d_body_entered(body: CrashBandicootState) -> void:
	check_collision_to_destroy(body, box_fracture)

func check_collision_to_destroy(body : CrashBandicootState, mesh : Node3D):
	body.collider = type_box_name
	if body.check_box_collision_state():
		body.is_colliding_with_boxes = true
		area_3d_collision_shape.call_deferred("set_disabled", true)
		destroy_box(body, mesh)
	

func destroy_box(crash_body : CrashBandicootState, meshes : Node3D):
	print("Estou Destruíndo a Caixa")
	static_body_collision_shape.call_deferred("set_disabled", true)
	add_rb_in_tree(meshes)
	crash_body.is_colliding_with_boxes = false
	status_ui.play_life_animation()
	destruction_timer.start()


func _on_destruction_timer_timeout() -> void:
	queue_free()
