extends Resource
class_name Army;

static var armies_created_count: int;

var army_id: int;
var unit_groups: Dictionary;
var province_id: int;
var nation_owner_id: int;
var desired_path: Array[int] = [];
var move_target: int = -1;
var move_progress: float = 0.0;
var speed: float = 50.0;
var defeated: bool = false;

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
	temp.armies.append(self.army_id);
	for i in GameInstance.game_instance.get_army_ids_in_province(target_province):
		temp.armies.append(i);
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
	
func add_unit(unit_name: String, count: int):
	if (not (unit_name in unit_groups.keys())):
		unit_groups[unit_name] = 0;
	unit_groups[unit_name] += count;

func get_unit_count() -> int:
	var output: int = 0;
	
	for k in unit_groups.keys():
		output += unit_groups[k];
	return (output);

func lose_unit(count: int = 0, unit_name: String = ""):
	if (not (unit_name in unit_groups.keys())):
		unit_groups[unit_name] = 0;
		return;
	if (unit_name == ""):
		for k in unit_groups.keys():
			unit_groups[k] -= count;
		return;
	unit_groups[unit_name] -= count;
	if (unit_groups[unit_name] < 0):
		unit_groups[unit_name] = 0;
		
		
func is_in_combat() -> bool:
	for c: Combat in GameInstance.game_instance.get_combats():
		if (self.army_id in c.armies):
			return (true);
	return (false);
	
func is_defeated() -> bool:
	return (defeated);
