extends State

func enter() -> void:
	char_owner.change_animation_speed_scale(1.0)
	char_owner.velocity = Vector3.ZERO
	char_owner.play_animation("CrashIdle")
	print("Estou no Estado de Idle")

func physics_update(delta: float) -> void:
	if char_owner.is_moving():
		char_owner.change_state("Walking")
	elif char_owner.is_jumping():
		char_owner.change_state("Jumping")
	elif char_owner.is_attacking():
		char_owner.change_state("Attacking")
	elif char_owner.is_dashing():
		char_owner.change_state("Dash")
