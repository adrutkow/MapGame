extends Node3D
class_name GameInstance;

static var game_instance: GameInstance;
var nations: Array[Nation];
var armies: Array[Army];
var provinces: Array[ProvinceState];
var day: int = 0;

var timer: int = 0;
var start: bool = false;
var lag: bool = false;

# Expanding borders with gold
# research/civics can reduce that cost

# great people, can assign to province, give stat to province
# vsauce +20% science to province

func _process(delta: float) -> void:
	timer += 1;
	if (timer > 60 and start):
		if multiplayer.is_server():
			if (NetworkManager.is_every_player_ready()):
				host_tick();
				timer = 0;

func _ready() -> void:
	GameInstance.game_instance = self;
	create_nations();
	create_provinces();
	Client.nation = get_nations()[0];
	
	summon_army(0, 0);
	summon_army(13, 2);
	summon_army(25, 4);

func host_tick():
	if (not multiplayer.is_server()):
		DevConsole.instance.add_line("Host tick request, im not server!");
		return;
	NetworkManager.send_clients_commands(NetworkManager.game_commands);
	NetworkManager.ask_clients_to_tick();
	tick();
	#while (not NetworkManager.is_every_player_ready()):
	#	DevConsole.instance.add_line("Not every player is ready!");
	#	await Utils.wait(1);
	NetworkManager.set_all_player_unready();

func tick_commands():
	for c in NetworkManager.game_commands:
		get_nations()[0].power += 1;
		DevConsole.instance.add_line("Processed command");
	NetworkManager.game_commands = [];

func tick_armies():
	for a: Army in get_armies():
		a.tick_movement();
	Map.map_instance.generate_mapview_military();

func tick():
	tick_commands();
	tick_armies();
	for p: ProvinceState in provinces:
		p.tick();
	day += 1;
	UIManager.instance.tick();
	
	while (lag):
		DevConsole.instance.add_line("Lagging...")
		await Utils.wait(1);
	
	NetworkManager.send_ready_to_host();

		
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

func get_armies() -> Array[Army]:
	return (armies);

func get_nation_by_id(id: int) -> Nation:
	return (get_nations()[id]);

func get_nation_id(nation: Nation) -> int:
	var n: Array[Nation];
	
	n = get_nations();
	for i in range(0, len(n)):
		if (n[i] == nation):
			return (i);
	return (-1);

func get_army_id_by_province(province_id: int) -> int:
	for a: Army in get_armies():
		if (a.province_id == province_id):
			return (a.army_id);
	return (-1);

func get_army_by_id(army_id: int) -> Army:
	for a: Army in get_armies():
		if (a.army_id == army_id):
			return (a);
	return (null);

func get_army_ids_in_province(province_id: int) -> Array[int]:
	var output: Array[int];
	
	for a: Army in get_armies():
		if (a.province_id == province_id):
			output.append(a.army_id)
	return (output);
	
func summon_army(province_id: int, nation_owner_id: int):
	var temp: Army;
	
	temp = Army.new();
	temp.army_id = Army.armies_created_count;
	temp.province_id = province_id;
	temp.nation_owner_id = nation_owner_id;
	Army.armies_created_count += 1;
	armies.append(temp);
	
