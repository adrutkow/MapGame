extends Resource
class_name ProvinceBuildingData;

@export var building_name: String = "building_default";
@export var display_name: String = "Default building";
@export var on_built_effects: Array[Effect];
@export var turn_effects: Array[Effect];
@export var icon: Texture2D;
@export var costs: Array[Cost];

func get_description(ctx: EffectContext):
	var s: String;
	
	s = "";
	s += TextUtils.bb_yellow_color();
	s += display_name;
	s += TextUtils.bb_end_color();
	s += "\n";
	#s += "Cost:\n";
	for c: Cost in costs:
		s += c.generate_description(ctx.nation);
		s += " ";
	s += "\n\n";
	s += TextUtils.effects_text();
	s += "\n";
	for e: Effect in on_built_effects:
		s += "	";
		s += e.get_description(ctx);
		s += "\n";
	# dog
	for e: Effect in turn_effects:
		s += "- ";
		s += e.get_description(ctx);
		s += "\n";
	return (s);
