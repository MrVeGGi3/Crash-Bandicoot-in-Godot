extends State

func enter() -> void:
	print("Estou atacando e caindo")
	char_owner.set_tree_transition_request("FallingAttack")
	#char_owner.play_animation("CrashFallingAttack")
	char_owner.bump_impulse_jump()
	char_owner.velocity.x = 0.0
	
func physics_update(delta: float) -> void:
	char_owner.apply_gravity(delta)
	
	
	if char_owner.is_on_floor():
		print("Estou colidindo com o chão")
		char_owner.change_state("Idle")
		
	
	
