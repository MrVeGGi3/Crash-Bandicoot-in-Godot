class_name AkuBox
extends Box

@onready var aku_box_fracture: Node3D = $AkuBoxFracture
@onready var aku_body_collision_shape: CollisionShape3D = $StaticBody3D/AkuBodyCollisionShape
@onready var aku_area_collision_shape: CollisionShape3D = $Area3D/AkuAreaCollisionShape

func _ready() -> void:
	type_box_name = "AkuBox"
	box_fracture = aku_box_fracture


func explode():
	queue_free()

func _on_area_3d_body_entered(body: CrashBandicootState) -> void:
	body.collider = type_box_name
	if body.check_box_collision_state():
		body.power_up()
		aku_area_collision_shape.call_deferred("set_disabled", true)
		add_rb_in_tree(aku_box_fracture)
		await get_tree().create_timer(0.5).timeout
		queue_free()
		
		
