extends Control
@onready var wumpa_quant_label: Label = $WumpaQuantLabel

@onready var initial_poistion: Marker2D = $InitialPoistion
@onready var final_position: Marker2D = $FinalPosition

var instance

func _process(delta: float) -> void:
	wumpa_quant_label.text = str(GameManager.fruits)


func _add_fruit():
	GameManager.add_fruits()
