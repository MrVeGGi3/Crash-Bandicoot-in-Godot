class_name Box
extends Node3D


const PARTICLE_RIGIBODY = preload("res://Scenes/Boxes/particle_rigibody.tscn")

##Transform Meshes into Rigidbodys to fragment the collision effect
@export var activate_rb_particles : bool = false



func add_rb_in_tree(root : Node):
	var meshes = get_all_mesh_instances(root)
	for mesh in meshes:
		instantiate_rb_particle(mesh)
	activate_rb_particles = true
		
func instantiate_rb_particle(mesh : MeshInstance3D):
	var rigid_instance = PARTICLE_RIGIBODY.instantiate()
	var original_transform = mesh.global_position 
	var old_parent = mesh.get_parent()
	
	old_parent.remove_child(mesh)
	old_parent.add_child(rigid_instance)
	rigid_instance.add_child(mesh)
	
	rigid_instance.global_position = original_transform
	mesh.transform = Transform3D.IDENTITY
	
func get_all_mesh_instances(roots : Node) -> Array:
	var mesh_instances = []
	for child in roots.get_children():
		if child is MeshInstance3D:
			mesh_instances.append(child)
	return mesh_instances

	
	
	
	
