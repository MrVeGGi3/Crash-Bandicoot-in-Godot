extends State

func enter() -> void:
	char_owner.play_animation("CrashAttack")
	
func physics_update(delta : float) -> void:
	char_owner.apply_gravity(delta)
	char_owner.move_character()
	
	if char_owner.is_on_floor() and not char_owner.is_animation_playing():
		char_owner.change_state("Idle")
	elif not char_owner.is_on_floor() and not char_owner.is_animation_playing():
		char_owner.change_state("Falling")
