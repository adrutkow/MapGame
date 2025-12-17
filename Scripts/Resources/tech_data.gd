extends Resource
class_name TechData;

@export var tech_name: String = "tech_default";
@export var display_name: String = "Default Technology";
@export var on_researched_effects: Array[Effect];
@export var turn_effects: Array[Effect];
@export var icon: Texture2D;
@export var tier: int = 1;

func get_description(ctx: EffectContext):
	var s: String;
	
	s = "";
	s += display_name;
	s += "\n\n";
	s += "WHEN RESEARCHED:\n";
	for e: Effect in on_researched_effects:
		s += "- ";
		s += e.get_description(ctx);
		s += "\n";
	s += "PER DAY:\n";
	for e: Effect in turn_effects:
		s += "- ";
		s += e.get_description(ctx);
		s += "\n";
	return (s);
