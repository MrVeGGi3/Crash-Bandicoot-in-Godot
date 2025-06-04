extends Node

signal fruits_to_life

@export_group("Elements Control")
@onready var lifes : int= 3
@onready var fruits : int= 0
@onready var max_boxes : int = 0
@onready var boxes_collected : int = 0

@export_group("Time Control")
var hours 
var minutes
var seconds
var time_start : bool = false

func add_box():
	boxes_collected += 1
func add_fruits():
	if fruits >= 100:
		emit_signal("fruits_to_life")
		fruits = 0
	else:
		fruits += 1
		
func add_life():
	lifes += 1
	
func subtract_life():
	if lifes <= 0:
		lifes = 0
	else:
		lifes -= 1
	
func reset_timer_count():
	seconds = 0.0
	minutes = 0.0
	hours = 0.0
			
func _process(delta: float) -> void:
	if time_start:
		seconds += 1 * delta
		if seconds >= 60:
			minutes += 1
			seconds = 0
		if minutes >= 60:
			hours += 1
			minutes = 0
	
