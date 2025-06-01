extends Node

@onready var crash  : CrashBandicoot = $".."

@onready var animation_player: AnimationPlayer = $"../CollisionShape3D/CrashAnimations/AnimationPlayer"
@onready var spinning_animation_player: AnimationPlayer = $"../CollisionShape3D/CrashSpinning/AnimationPlayer"


@onready var crash_spinning: Node3D = %CrashSpinning
@onready var crash_animations: Node3D = %CrashAnimations


func _ready() -> void:
	crash.state_changed.connect(change_animation)
	_disable_spin_animation() 
	
	
func change_animation(state):
	match state:
		crash.CrashState.IDLE:
			animation_player.play("CrashIdle")
		crash.CrashState.JUMPING:
			animation_player.play("CrashJumping")
		crash.CrashState.FELT:
			animation_player.play("CrashFelt")
		crash.CrashState.WALKING:
			animation_player.play("CrashWalking")
		crash.CrashState.DASHING:
			animation_player.play("CrashDash")
		crash.CrashState.FALLING:
			animation_player.play("CrashFalling")
		crash.CrashState.FALLATTACK:
			animation_player.play("CrashFallingAttack")
		crash.CrashState.ATTACKING:
			spinning_animation_player.play("CrashAttack")
			
			
func _disable_spin_animation():
	crash_spinning.hide()


func _on_spinning_animation_player_animation_finished(anim_name: StringName) -> void:
	crash_spinning.hide()
	crash.current_state = crash.CrashState.IDLE


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "CrashFelt":
		crash.current_state = crash.CrashState.IDLE
	elif anim_name == "CrashAttack":
		if crash.velocity.y < 0:
			crash.current_state = crash.CrashState.FALLING
		else:
			crash.current_state = crash.CrashState.IDLE

	
