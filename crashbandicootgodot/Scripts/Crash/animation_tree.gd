extends AnimationTree

@onready var crash : CrashBandicoot = $".."
@onready var animation_tree: AnimationTree = $"."

const STATE_TO_CONDITION = {
	crash.CrashState.IDLE: "idle",
	crash.CrashState.WALKING: "walk",
	crash.CrashState.JUMPING: "jump",
	crash.CrashState.ATTACKING: "jump",
	crash.CrashState.FALLATTACK: "fall_a",
	crash.CrashState.FALLING: "fall"
	
}


func _process(delta: float) -> void:
	select_animation_state(crash.current_state)
	
func select_animation_state(state):
	reset_all_conditions(state)
	if STATE_TO_CONDITION.has(state):
		var cond = STATE_TO_CONDITION[state]
		animation_tree["parameters/conditions/%s" % cond] = true
		

func reset_all_conditions(state):
	for key in STATE_TO_CONDITION.values():
		if STATE_TO_CONDITION.has(state):
			continue
		else:
			animation_tree["parameters/conditions/%s" % key] = false
