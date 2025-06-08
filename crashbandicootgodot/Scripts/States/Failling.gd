extends State

func enter() -> void:
	char_owner.set_tree_transition_request("Fall")
	#char_owner.play_animation("CrashFalling")
	print("Estou no Estado de Cair")

func physics_update(delta : float) -> void:
	char_owner.apply_gravity(delta)
	char_owner.move_character()
	char_owner.check_box_collision()

	if char_owner.is_on_floor():
		char_owner.change_state("Felt")
	elif char_owner.is_attacking():
		char_owner.change_state("Attacking")
