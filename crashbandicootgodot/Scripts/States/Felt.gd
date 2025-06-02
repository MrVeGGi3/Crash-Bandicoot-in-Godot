extends State

func enter() -> void:
	char_owner.play_animation("CrashFelt")
	print("Estou no Estado de Caído")

func physics_update(delta : float) -> void:
	if char_owner.is_on_floor() and not char_owner.is_animation_playing():
		char_owner.change_state("Idle")
		
