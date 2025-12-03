extends Node3D
class_name GameInstance;

static var game_instance: GameInstance;
var nations: Array[Nation];
var provinces: Array[ProvinceState];
var day: int = 0;

var prov1: int = -1;
var prov2: int = -1;

var timer: int = 0;

# Expanding borders with gold
# research/civics can reduce that cost

# great people, can assign to province, give stat to province
# vsauce +20% science to province

func _process(delta: float) -> void:
	timer += 1;
	if (timer > 60):
		pass;

func _ready() -> void:
	GameInstance.game_instance = self;
	create_nations();
	create_provinces();
	Client.nation = get_nations()[0];


func tick():
	
	if (multiplayer.is_server()):
		if (not NetworkManager.is_every_player_ready()):
			DevConsole.instance.add_line("Not every player is ready!");
			return;
	
	for c in NetworkManager.game_commands:
		get_nations()[0].power += 1;
		DevConsole.instance.add_line("Processed command");

	NetworkManager.game_commands = [];
	for p: ProvinceState in provinces:
		p.tick();
	day += 1;
	UIManager.instance.tick();
	NetworkManager.send_ready_to_host();
	if (multiplayer.is_server()):
		NetworkManager.set_all_player_unready();
		
func create_nations():
	var temp: Nation;
	for n: NationData in GameGlobal.nation_data_list.nation_list:
		temp = Nation.new();
		temp.set_values_from_nation_data(n);
		nations.append(temp);
		
	temp = Nation.new();
	temp.nation_name = "Biters";
	temp.nation_color = Color.FIREBRICK;
	temp.owned_provinces.append(69);
	temp.owned_provinces.append(71);
	
	nations.append(temp);
	
	temp = Nation.new();
	temp.nation_name = "Rats";
	temp.nation_color = Color.DIM_GRAY;
	temp.owned_provinces.append(58);
	temp.owned_provinces.append(66);
	
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
