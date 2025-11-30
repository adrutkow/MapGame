@tool

extends MeshInstance3D




func _ready() -> void:
	mesh.clear_surfaces();
	mesh.surface_begin(Mesh.PRIMITIVE_LINES);
	mesh.surface_add_vertex(Vector3.ZERO)
	#mesh.surface_add_vertex(Vector3(2.5, 0.5, 2.5));
	mesh.surface_add_vertex(Vector3(randf() * 100, randf() * 100, randf() * 100));
	
	mesh.surface_end();
