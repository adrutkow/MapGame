extends Node3D
class_name ArmyCube;


func set_army_count_text(i: int):
	$Label3D.text = str(i);

func set_army_count_text_color(c: Color):
	$Label3D.modulate = c;

func set_color(c: Color):
	var m: StandardMaterial3D;

	if ($Mesh.material_override == null):
		m = StandardMaterial3D.new();
		$Mesh.material_override = m;
	m.albedo_color = c
	m.vertex_color_use_as_albedo = true;
	m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED;
