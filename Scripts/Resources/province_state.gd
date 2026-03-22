extends Resource
class_name ProvinceState;

var province_data: ProvinceData;
var buildings: Array[String];
var great_people: Array[String];
var last_generated_currency: Dictionary;

func tick():
	var owner: Nation;
	var effect_context: EffectContext;
	
	owner = get_owner();
	if (not owner):
		return;
	
	effect_context = EffectContext.new();
	effect_context.nation = owner;
	effect_context.province_state = self;
	
	for b: String in get_buildings():
		var b_data: ProvinceBuildingData;
		
		b_data = GameGlobal.get_province_building_data_by_name(b);
		if (not b_data):
			continue;
		for e: Effect in b_data.turn_effects:
			e.tick(effect_context);
	
	var currencies = [];
	for c: CurrencyData in GameGlobal.currency_data_list.list:
		currencies.append(c.currency_name);

	for c: String in currencies:
		owner.give_currency(c, get_currency_income(c));
		owner.give_currency(c, -(get_currency_upkeep(c)));

func get_owner() -> Nation:
	var id: int;
	
	id = province_data.id;
	if (not GameInstance.game_instance):
		return (null);
	for n: Nation in GameInstance.game_instance.get_nations():
		if (id in n.owned_provinces):
			return (n);
	return (null);

func add_building(n: String):
	var b_data: ProvinceBuildingData;
	var effect_context: EffectContext;
		
	effect_context = EffectContext.new();
	effect_context.nation = get_owner();
	effect_context.province_state = self;
	b_data = GameGlobal.get_province_building_data_by_name(n);
	buildings.append(n);
	for e: Effect in b_data.on_built_effects:
		e.tick(effect_context);

func add_great_person(n: String):
	great_people.append(n);

func get_buildings() -> Array[String]:
	return (buildings);

func get_great_people() -> Array[String]:
	return (great_people);

func get_currency_income(currency_name: String) -> float:
	var output: float = 0;
	var building_data: ProvinceBuildingData;
	var great_person_data: GreatPersonData;
	var bonus: float = 0;
	
	for building_name: String in get_buildings():
		building_data = GameGlobal.get_province_building_data_by_name(building_name);
		for e: Effect in building_data.on_built_effects:
			if (e is EGiveCurrency):
				if (e.currency_name == currency_name and e.daily):
					output += e.intensity;

			if (e is EGiveCurrencyMultiplier):
				if (e.currency_name == currency_name):
					bonus += e.percentage;
					
	for great_person_name: String in get_great_people():
		great_person_data = GameGlobal.get_great_person_data_by_name(great_person_name);
		for e: Effect in great_person_data.effects:
			if (e is EGiveCurrency):
				if (e.currency_name == currency_name and e.daily):
					output += e.intensity;
			
			if (e is EGiveCurrencyMultiplier):
				if (e.currency_name == currency_name):
					bonus += e.percentage;
		
	output += output * bonus/100;
	last_generated_currency[currency_name] = output;
	return (output);

func get_currency_upkeep(currency_name: String) -> float:
	var output: float = 0;
	var building_data: ProvinceBuildingData;
	var great_person_data: GreatPersonData;
	var bonus: float = 0;

	for building_name: String in get_buildings():
		building_data = GameGlobal.get_province_building_data_by_name(building_name);
		for c: Cost in building_data.maintenance_costs:
			if (c.currency_name == currency_name):
				output += c.amount;

	for great_person_name: String in get_great_people():
		great_person_data = GameGlobal.get_great_person_data_by_name(great_person_name);
		for c: Cost in great_person_data.maintenance_costs:
			if (c.currency_name == currency_name):
				output += c.amount;
		
	output += output * bonus/100;
	last_generated_currency[currency_name] = -output;

	return (output);
