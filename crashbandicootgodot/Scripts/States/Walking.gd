extends State

func enter() -> void:
	char_owner.set_tree_transition_request("IdleWalk")
	print("Estou no estado de Andar")

func physics_update(delta : float) -> void:
	char_owner.move_character()
	char_owner.set_walk_blend_value()
	
	
	if not char_owner.is_moving():
		char_owner.change_state("Idle")
	elif char_owner.is_jumping():
		char_owner.change_state("Jumping")
	elif char_owner.is_attacking():
		char_owner.change_state("Attacking")
	elif char_owner.is_dashing():
		char_owner.change_state("Dash")
