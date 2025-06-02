extends State

func enter() -> void:
	char_owner.velocity.y += char_owner.jump_force
	char_owner.play_animation("CrashJumping")
	print("Estou no Estado de Pular")

func physics_update(delta : float) -> void:
	char_owner.apply_gravity(delta)
	char_owner.move_character()
	print(char_owner.velocity.y)
	
	if char_owner.velocity.y < 0:
		char_owner.change_state("Falling")
	elif char_owner.is_attacking():
		char_owner.change_state("Attacking")
	elif char_owner.is_dashing():
		char_owner.change_state("FallAttack")
		
