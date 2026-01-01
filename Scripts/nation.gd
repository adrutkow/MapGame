extends Resource
class_name Nation;

@export var owned_provinces: Array[int];
@export var nation_name: String;
@export var nation_color: Color;
var nation_id: int = 0;
var science: float = 0;
var culture: float = 0;
var gold: float = 0;
var happiness: float = 0;
var power: float = 0;
var allied_nations: Array[int] = [];
var flag: Texture2D;

func set_values_from_nation_data(nation_data: NationData):
	owned_provinces = nation_data.owned_provinces.duplicate();
	nation_name = nation_data.nation_name;
	nation_color = nation_data.nation_color;
	science = nation_data.start_science;
	culture = nation_data.start_culture;
	gold = nation_data.start_gold;
	happiness = nation_data.start_happiness;
	power = nation_data.start_power;
	flag = nation_data.nation_flag;


func get_owned_provinces_id() -> Array[int]:
	return (owned_provinces);

func get_nation_id() -> int:
	var nation_list: Array[Nation];
	
	if (GameInstance.game_instance):
		nation_list = GameInstance.game_instance.get_nations();
		for i in range(0, len(nation_list)):
			if self == nation_list[i]:
				return (i);
	return (-1);
	
func give_gold(amount: float):
	gold += amount;

func give_province(province_id: int):
	if (GameInstance.game_instance.get_province_owner(province_id) != null):
		return;
	owned_provinces.append(province_id);

func get_purchasable_provinces() -> Array[int]:
	var output: Array[int] = [];
	
	for p_id: int in get_owned_provinces_id():
		var adj: Array[int];
		
		adj = GameGlobal.get_province_adjacencies(p_id);
		for _p_id: int in adj:
			if (GameInstance.game_instance.get_province_owner(_p_id) == null):
				output.append(_p_id);
	
	return (output);
	
	
