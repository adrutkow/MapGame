extends Resource
class_name Army;

static var armies_created_count: int;

var army_id: int;
var unit_groups: Dictionary;
var province_id: int;
var nation_owner_id: int;

func add_unit(unit_name: String, count: int):
	if (not (unit_name in unit_groups.keys())):
		unit_groups[unit_name] = 0;
	unit_groups[unit_name] += count;
