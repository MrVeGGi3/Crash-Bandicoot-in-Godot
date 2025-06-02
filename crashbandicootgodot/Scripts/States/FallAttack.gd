extends State

func enter() -> void:
	char_owner.play_animation("CrashFallingAttack")
	char_owner.velocity.y += char_owner.bump_speed
	
func physics_update(delta: float) -> void:
	char_owner.apply_gravity(delta)
	char_owner.move_character()
	
	if char_owner.is_on_floor():
		char_owner.change_state("Idle")
	
	
