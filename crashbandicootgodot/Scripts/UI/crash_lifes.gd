extends Control
@onready var crash_control_label: Label = $CrashControlLabel


func _process(delta: float) -> void:
	crash_control_label.text = str(GameManager.lifes)
	
func _add_lifes():
	GameManager.add_life()
