extends State

func enter() -> void:
	char_owner.play_animation("CrashFalling")
	print("Estou no Estado de Cair")

func physics_update(delta : float) -> void:
	char_owner.apply_gravity(delta)
	char_owner.move_character()

	if char_owner.is_on_floor():
		char_owner.change_state("Felt")
	elif char_owner.is_attacking():
		char_owner.change_state("Attacking")
