class_name Wumpa
extends Area3D

@export var speed_rotation = 0.05
signal wumpa_collected

func _on_body_entered(body: CrashBandicootState) -> void:
	emit_signal("wumpa_collected")
	queue_free()

func _physics_process(delta: float) -> void:
	rotation.y += speed_rotation * delta
