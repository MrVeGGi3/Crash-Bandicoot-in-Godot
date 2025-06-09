class_name NormalBox
extends Box

@onready var normal_box_fracture: Node3D = $NormalBoxFracture
@onready var destruction_timer: Timer = $DestructionTimer
@onready var static_body_collision_shape: CollisionShape3D = $StaticBody3D/StaticBodyCollisionShape
@onready var area_3d_collision_shape: CollisionShape3D = $Area3D/Area3DCollisionShape

@export var status_ui : Control 

const WUMPA = preload("res://Scenes/Wumpa/Wumpa.tscn")
var add_position = Vector3(0,-10, 0)


@export var fruits_to_instantiate : int = 1

func _on_destruction_timer_timeout() -> void:
	queue_free()

func instantiate_fruits(quantity : int) -> void:
	for i in range(quantity):
		var wumpa_instance = WUMPA.instantiate()
		get_parent().add_child(wumpa_instance)
		if wumpa_instance.is_inside_tree():
			wumpa_instance.global_position = global_position - add_position
			wumpa_instance.wumpa_collected.connect(status_ui.play_fruit_animation)

func destroy_box(crash_body : CrashBandicootState):
	print("Estou Destruíndo a Caixa")
	static_body_collision_shape.call_deferred("set_disabled", true)
	add_rb_in_tree(normal_box_fracture)
	instantiate_fruits(fruits_to_instantiate)
	crash_body.is_colliding_with_boxes = false
	destruction_timer.start()
	
func _on_area_3d_body_entered(body: CrashBandicootState) -> void:
	body.collider = "NormalBox"
	if body.check_box_collision_state():
		body.is_colliding_with_boxes = true
		area_3d_collision_shape.disabled
		destroy_box(body)
