extends Resource
class_name Army;

static var armies_created_count: int;

var army_id: int;
var troop_groups: Array[Dictionary];
var general: String = "";
var province_id: int;
var nation_owner_id: int;
var desired_path: Array[int] = [];
var move_target: int = -1;
var move_progress: float = 0.0;
var speed: float = 50.0;
var defeated: bool = false;

# Unit = individual soldier;
# Troop = group of soldiers;

var default_troop_group = {
	"troop_name": "troop_default",
	"unit_count": 0,
	"troop_morale": 100.0,
}

func tick_movement():
	move_progress += speed;
	if (move_progress >= 100.0):
		move_progress = 0;
		move_target = get_next_move_target();
		move_to_province(move_target);
			
func move_to_province(p: int):
	var armies: Array[int];
	
	armies = GameInstance.game_instance.get_army_ids_in_province(p);
	if (not is_defeated() and GameInstance.game_instance.province_has_active_enemy_army(p)):
		start_combat(p); 
		return;
	
	if (p != -1):
		province_id = p;

func start_combat(target_province: int):
	var temp: Combat;
	
	temp = Combat.new();
	temp.attacker_armies.append(self.army_id);
	for i in GameInstance.game_instance.get_army_ids_in_province(target_province):
		temp.defender_armies.append(i);
	desired_path = [];
	
	GameInstance.game_instance.combats.append(temp);
	DevConsole.instance.add_line("Started new combat");

func get_next_move_target() -> int:
	var current_path_index: int = -1;
	
	current_path_index = desired_path.find(province_id);
	if (current_path_index == -1):
		return (-1);
	if (current_path_index == len(desired_path) - 1):
		return (-1);
	return (desired_path[current_path_index + 1]);
	
func create_troop_dict(troop_name: String,
	unit_count: int = 1000, morale: float = 100.0) -> Dictionary:
		var output: Dictionary;

		output = {
			"troop_name": troop_name,
			"unit_count": unit_count,
			"troop_morale": morale,
		}
		return (output);

func add_troop(troop_name: String, unit_count: int = 1000, morale: float = 100.0):
	var new: Dictionary;

	new = create_troop_dict(troop_name, unit_count, morale);
	troop_groups.append(new);

func add_unit(unit_name: String, count: int):
	for t in troop_groups:
		if (count == 0):
			return;
		var unit_count: int = t["unit_count"];
		if (unit_count < 1000):
			var max_add: int = 1000 - unit_count;

			if (count <= max_add):
				t["unit_count"] += count;
				count = 0;
			else:
				t["unit_count"] += max_add;
				count -= max_add;
	if (count > 0):
		add_troop(unit_name, count);

func get_unit_count() -> int:
	var output: int = 0;
	
	for t in troop_groups:
		output += t["unit_count"];
	return (output);

func lose_unit(count: int = 0, unit_name: String = ""):
	for t in troop_groups:
		if (count == 0):
			return;
		if (t["troop_name"] == unit_name):
			if (t["unit_count"] >= count):
				t["unit_count"] -= count;
				count = 0;
			else:
				count -= t["unit_count"];
				t["unit_count"] = 0;
		
func is_in_combat() -> bool:
	for c: Combat in GameInstance.game_instance.get_combats():
		if (self.army_id in c.armies):
			return (true);
	return (false);
	
func is_defeated() -> bool:
	return (defeated);
	
func is_in_own_territory() -> bool:
	var province: ProvinceState;
	
	province = GameInstance.game_instance.get_province_by_id(province_id);
	if (not province):
		return (false);
	if (province.get_owner().get_nation_id() == nation_owner_id):
		return (true);
	return (false);
	
func get_trainable_troops() -> Array[String]:
	var output: Array[String] = [];
	var province: ProvinceState;
	var buildings: Array[String];
	
	province = GameInstance.game_instance.get_province_by_id(province_id);
	if (not province):
		return (output);
	if (not is_in_own_territory()):
		return (output);
	buildings = province.get_buildings();
	for building_name: String in buildings:
		var building_data: ProvinceBuildingData;
		
		building_data = GameGlobal.get_province_building_data_by_name(building_name);
		for e: Effect in building_data.on_built_effects:
			if (e is EEnableTroopTraining):
				for t: String in e.trainable_troops:
					output.append(t);
		
	return (output);

func get_troop_types() -> Array[String]:
	var output: Array[String] = []
	
	for t in troop_groups:
		output.append(t["troop_name"]);
	return (output);

func get_total_morale() -> float:
	var output: float = 0;

	for t in troop_groups:
		output += t["troop_morale"];
	return (output);
