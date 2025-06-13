class_name Explosion
extends Area3D

@onready var effect_timer: Timer = $EffectTimer
@onready var boxes = get_tree().get_nodes_in_group("Box")
@onready var crash = get_tree().get_first_node_in_group("Crash")
@onready var minimum_distance = 10.0

func _ready() -> void:
	effect_timer.start()
	

func _on_effect_timer_timeout() -> void:
	queue_free()
