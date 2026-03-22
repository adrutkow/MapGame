extends Resource
class_name Nation;

@export var owned_provinces: Array[int];
@export var nation_name: String;
@export var nation_color: Color;
var allied_nations: Array[int] = [];
var flag: Texture2D;
var currencies: Dictionary;

func set_values_from_nation_data(nation_data: NationData):
	owned_provinces = nation_data.owned_provinces.duplicate();
	nation_name = nation_data.nation_name;
	nation_color = nation_data.nation_color;
	give_currency("currency_science", nation_data.start_science);
	# culture = nation_data.start_culture;
	# gold = nation_data.start_gold;
	# happiness = nation_data.start_happiness;
	# power = nation_data.start_power;
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

func give_currency(currency_name: String, amount: float):
	# if (currency_name == "currency_science"):
	# 	science += amount;
	# if (currency_name == "currency_culture"):
	# 	culture += amount;
	# if (currency_name == "currency_gold"):
	# 	gold += amount;
	# if (currency_name == "currency_power"):
	# 	power += amount;
	# if (currency_name == "currency_happiness"):
	# 	happiness += amount;
	if (not currencies.has(currency_name)):
		currencies[currency_name] = 0.0;
	currencies[currency_name] += amount;

func get_currency_amount_by_name(currency_name: String) -> float:
	#if (currency_name == "currency_science"):
		#return (science);
	#if (currency_name == "currency_culture"):
		#return (culture);
	#if (currency_name == "currency_gold"):
		#return (gold);
	#if (currency_name == "currency_power"):
		#return (power);
	#if (currency_name == "currency_happiness"):
		#return (happiness);
	if (currencies.has(currency_name)):
		return (currencies[currency_name]);
	return (0);

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
	
	
