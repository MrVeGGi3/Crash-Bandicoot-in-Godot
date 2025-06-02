extends AnimationTree

@onready var crash : CrashBandicootState = $".."
@onready var animation_tree: AnimationTree = $"."

func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"CrashFelt", "CrashDash":
			crash.change_state("Idle")
		"CrashAttack":
			if crash.velocity.y < 0:
				crash.change_state("Falling")
			else:
				crash.change_state("Idle")
