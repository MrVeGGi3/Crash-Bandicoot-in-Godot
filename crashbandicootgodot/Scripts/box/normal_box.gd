class_name NormalBox
extends Box

@onready var normal_box_fracture: Node3D = $NormalBoxFracture
@onready var destruction_timer: Timer = $DestructionTimer
@onready var static_body_collision_shape: CollisionShape3D = $StaticBodyCollisionShape
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

func destroy_box():
	print("Estou Destruíndo a Caixa")
	static_body_collision_shape.disabled = true
	add_rb_in_tree(normal_box_fracture)
	instantiate_fruits(fruits_to_instantiate)
	destruction_timer.start()
