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

func tick_movement():
	DevConsole.instance.add_line("tick movement")
	move_progress += speed;
	if (move_progress >= 100.0):
		DevConsole.instance.add_line("Trying to move");
		move_progress = 0;
		move_target = get_next_move_target();
		if (move_target != -1):
			province_id = move_target;

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
