class_name Box
extends Node3D


const PARTICLE_RIGIBODY = preload("res://Scenes/Boxes/particle_rigibody.tscn")

##Transform Meshes into Rigidbodys to fragment the collision effect
var type_box_name : String
var box_fracture : Node3D
var has_exploded : bool = false
@export var status_ui : UIControl

func add_rb_in_tree(root : Node):
	var meshes = get_all_mesh_instances(root)
	for mesh in meshes:
		instantiate_rb_particle(mesh)
		
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


	
	
	
