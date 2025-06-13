class_name TNTBox
extends ExplosiveBox


@onready var tnt_animation: AnimationPlayer = $TNTAnimation

@onready var tnt_3_box: Node3D = $TNT3Box
@onready var tnt_2_box: Node3D = $TNT2Box
@onready var tnt_1_box_fracture: Node3D = $TNT1BoxFracture
@onready var area_3d_collision_shape: CollisionShape3D = $Area3D/Area3DCollisionShape



func _ready() -> void:
	type_box_name = "TNTBox"
	box_fracture = $TNT1BoxFracture
	
func fragment_mesh():
	add_rb_in_tree(box_fracture)


func _on_area_3d_body_entered(body: CrashBandicootState) -> void:
	body.collider = type_box_name
	var can_activate = (
		body.current_state == body.states["Falling"] or
		body.current_state == body.states["Jumping"]
	)
	
	if body.check_box_collision_state():
		area_3d_collision_shape.call_deferred("set_disabled", true)
		fragment_mesh()
		body.die()
		
	elif can_activate:
		area_3d_collision_shape.call_deferred("set_disabled", true)
		tnt_animation.play("TNTActivated")

func hide_meshes_in_start():
	tnt_1_box_fracture.hide()
	tnt_2_box.hide()
	tnt_3_box.hide()
		
