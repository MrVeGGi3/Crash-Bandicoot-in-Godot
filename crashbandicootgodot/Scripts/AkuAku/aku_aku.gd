class_name AkuAku
extends Node3D


@onready var crash : CrashBandicootState = $".."
func _ready() -> void:
	hide()


func _process(delta: float) -> void:
	if visible:
		align_rotation_with_crash()
	
func align_rotation_with_crash():
	rotation = crash._skin.rotation - Vector3(0,-180,0)
	
	
