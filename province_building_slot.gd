extends IconSlot;
class_name ProvinceBuildingSlot

var building_name: String = "none";

func tick():
	if (building_name == "none"):
		return;
		
func update():
	if (building_name == "none"):
		set_texture(null);
		return;
	set_texture(GameGlobal.get_province_building_data_by_name(building_name).icon);

func get_hover_text() -> String:
	var building_data: ProvinceBuildingData;
	var effect_context: EffectContext;
	var s: String;
	
	effect_context = EffectContext.new()
	effect_context.nation = Client.get_nation();
	building_data = GameGlobal.get_province_building_data_by_name(building_name);
	s = "";
	
	if (not building_data):
		return ("");
		
	s += building_data.display_name;
	s += "\n\n";
	
	s += "ON BUILT:\n";
	
	for e: Effect in building_data.on_built_effects:
		s += "- ";
		s += e.get_description(effect_context);
		s += "\n";
	
	s += "PER DAY:\n";
	
	for e: Effect in building_data.turn_effects:
		s += "- ";
		s += e.get_description(effect_context);
		s += "\n";
	return (s);
