extends Node3D
class_name GameInstance;

static var game_instance: GameInstance;
var nations: Array[Nation];
var provinces: Array[ProvinceState];
var day: int = 0;


# Expanding borders with gold
# research/civics can reduce that cost


func _ready() -> void:
	GameInstance.game_instance = self;
	
	create_nations();
	create_provinces();



func tick():
	for p: ProvinceState in provinces:
		p.tick();
	day += 1;
	Client.client_instance.get_ui_manager().tick();
		
func create_nations():
	var temp: Nation;
	for n: NationData in GameGlobal.nation_data_list.nation_list:
		temp = Nation.new();
		temp.set_values_from_nation_data(n);
		nations.append(temp);

func create_provinces():
	var temp: ProvinceState;
	for p: ProvinceData in GameGlobal.province_data_list.province_list:
		temp = ProvinceState.new();
		temp.province_data = p;
		provinces.append(temp);

func get_nations() -> Array[Nation]:
	var output: Array[Nation];
	
	for n: Nation in nations:
		output.append(n);
	return (output);

func get_nation_by_id(id: int) -> Nation:
	return (get_nations()[id]);

func get_nation_id(nation: Nation) -> int:
	var n: Array[Nation];
	
	n = get_nations();
	for i in range(0, len(n)):
		if (n[i] == nation):
			return (i);
	return (-1);
