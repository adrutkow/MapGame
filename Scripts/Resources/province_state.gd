extends Resource
class_name ProvinceState;

var province_data: ProvinceData;
var buildings: Array[String];
var great_people: Array[String];

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
