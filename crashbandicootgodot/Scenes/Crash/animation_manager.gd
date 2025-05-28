extends Node

@onready var crash  : CrashBandicoot = $".."
@onready var animation_player: AnimationPlayer = $"../CollisionShape3D/CrashAnimations/AnimationPlayer"

func _ready() -> void:
	crash.state_changed.connect(change_animation)
	
	
func change_animation(state):
	match state:
		crash.CrashState.IDLE:
			animation_player.play("CrashIdle")
		crash.CrashState.JUMPING:
			animation_player.play("CrashJumping")
		crash.CrashState.FALLING:
			animation_player.play("CrashFailing")
		crash.CrashState.WALKING:
			animation_player.play("CrashWalking")
		crash.CrashState.DASHING:
			animation_player.play("CrashDash")
	
