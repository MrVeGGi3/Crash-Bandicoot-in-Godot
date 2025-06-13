extends AudioStreamPlayer

@onready var crash_bandicoot: CrashBandicootState = $"../.."

func _ready() -> void:
	crash_bandicoot.powered_up.connect(play)
