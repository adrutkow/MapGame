extends Node3D
class_name ArmyCube;

var army_count: int = 1;
var army_id: int = -1;
var province_id: int = -1;

func set_troop_count_text(i: int):
	$TroopCount.text = str(i);

func set_troop_count_text_color(c: Color):
	$TroopCount.modulate = c;

func set_color(c: Color):
	var m: StandardMaterial3D;

	if ($Mesh.material_override == null):
		m = StandardMaterial3D.new();
		$Mesh.material_override = m;
	m.albedo_color = c
	m.vertex_color_use_as_albedo = true;
	m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED;

func set_army_count_text(i: int):
	pass;
	
func offset_troop_count_text(count: int):
	var base_height: float;
	
	base_height = $TroopCount.position.y;
	$TroopCount.position.y = base_height + count * 0.25;

func draw_selected():
	$TroopCount.outline_modulate = Color.GREEN;

func draw_unselected():
	$TroopCount.outline_modulate = Color.BLACK;
