class_name Wumpa
extends Area3D

signal wumpa_collected

func _on_body_entered(body: CrashBandicootState) -> void:
	emit_signal("wumpa_collected")
	queue_free()
