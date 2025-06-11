class_name ExplosiveBox
extends Box

const EXPLOSION = preload("res://Scenes/Effects/Explosion.tscn")

func instantiate_explosion():
	print("TNTBOX: Estou instanciando a Explosão")
	var explosion_instance = EXPLOSION.instantiate()
	get_parent().add_child(explosion_instance)
	if explosion_instance.is_inside_tree():
		explosion_instance.global_position = global_position
		
func explode():
	instantiate_explosion()
	queue_free()
