extends State

func enter() -> void:
	char_owner.play_animation("CrashDash")
	char_owner.velocity = owner.get_dash_direction() * owner.dash_speed

func physics_update(delta: float) -> void:
	char_owner.apply_gravity(delta)
	char_owner.move_and_slide()

	if not char_owner.is_animation_playing():
		if char_owner.is_on_floor():
			char_owner.change_state("Idle")
		else:
			char_owner.change_state("Falling")
