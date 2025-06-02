extends State

func enter() -> void:
	char_owner.play_animation("CrashWalking")
	print("Estou no estado de Andar")

func physics_update(delta : float) -> void:
	char_owner.move_character()
	
	if not char_owner.is_moving():
		char_owner.change_state("Idle")
	elif char_owner.is_jumping():
		char_owner.change_state("Jumping")
	elif char_owner.is_attacking():
		char_owner.change_state("Attacking")
	elif char_owner.is_dashing():
		char_owner.change_state("Dash")
