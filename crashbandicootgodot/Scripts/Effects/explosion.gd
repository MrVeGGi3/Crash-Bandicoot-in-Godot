class_name Explosion
extends Area3D

@onready var effect_timer: Timer = $EffectTimer


func _ready() -> void:
	effect_timer.start()

func _on_body_entered(body: Node3D) -> void:
	if body is CrashBandicootState:
		body.die()
		print("Explosion: Acertei o Crash")
		
	if body is ExplosiveBox:
		print("Explosion: Acertei uma Caixa")
		body.explode()
	
func _on_effect_timer_timeout() -> void:
	queue_free()
