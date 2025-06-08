extends State

func enter() -> void:
	char_owner.set_tree_transition_request("Dash")
	char_owner.play_animation("CrashDash")
	char_owner.velocity = char_owner.get_dash_direction() * char_owner.dash_speed if char_owner.get_dash_direction().length() > 0.0 else Vector3.ZERO
	print("Estou no Estado de Dash")
	
func physics_update(delta: float) -> void:
	char_owner.check_box_collision()
	char_owner.apply_gravity(delta)
	char_owner.move_and_slide()

	if not char_owner.is_animation_playing():
		if char_owner.is_on_floor():
			char_owner.change_state("Idle")
		else:
			char_owner.change_state("Falling")
