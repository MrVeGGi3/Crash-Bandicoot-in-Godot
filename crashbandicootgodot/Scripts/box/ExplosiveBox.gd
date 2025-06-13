class_name ExplosiveBox
extends Box

@export var explosion_minimum_distance = 20.0
@onready var crash = get_tree().get_first_node_in_group("Crash")
		
func explode():
	if has_exploded:
		return
	has_exploded = true
	check_near_boxes_to_explode()
	check_crash_to_kill()
	queue_free()
	
func check_near_boxes_to_explode():
	var boxes = get_tree().get_nodes_in_group("Box")
	for box in boxes:
		if box == self:
			continue
		var box_position = box.global_position
		var distance = global_position.distance_to(box_position)
		if distance < explosion_minimum_distance:
			box.explode()
		
func check_crash_to_kill():
	if crash == null:
		return
	var crash_position = crash.global_position
	var distance = global_position.distance_to(crash_position)
	if distance < explosion_minimum_distance:
		crash.die()
