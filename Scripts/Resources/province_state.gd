extends Resource
class_name ProvinceState;

var province_data: ProvinceData;

func tick():
	var owner: Nation;
	
	owner = get_owner();
	if (not owner):
		return;
	get_owner().science += 1;

func get_owner() -> Nation:
	var id: int;
	
	id = province_data.id;
	if (not GameInstance.game_instance):
		return (null);
	for n: Nation in GameInstance.game_instance.get_nations():
		if (id in n.owned_provinces):
			return (n);
	return (null);
