extends State


func enter() -> void:
	char_owner.velocity = Vector3.ZERO
	char_owner.set_tree_transition_request("IdleWalk")
	print("Estou no Estado de Idle")

func physics_update(delta: float) -> void:
	char_owner.apply_gravity(delta)
	char_owner.set_walk_blend_value()
	
	if char_owner.is_moving():
		char_owner.set_walk_blend_value()
		char_owner.change_state("Walking")
	elif char_owner.is_jumping():
		char_owner.change_state("Jumping")
	elif char_owner.is_attacking():
		char_owner.change_state("Attacking")
	elif char_owner.velocity.y < 0 and not char_owner.is_on_floor():
		char_owner.change_state("Falling")
	
	
