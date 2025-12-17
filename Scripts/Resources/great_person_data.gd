extends Resource
class_name GreatPersonData;

@export var gp_name: String = "gp_default";
@export var display_name: String = "Default Great Person";
@export var icon: Texture2D;
@export var description: String = "";
@export var effects: Array[Effect];

func get_description(ctx: EffectContext):
	var s: String;
	
	s = "";
	s += display_name;
	s += "\n";
	s += description;
	if (len(effects) == 0):
		return(s);
	s += "\n";
	s += "\n";
	s += "EFFECTS:\n";
	for e: Effect in effects:
		s += "- ";
		s += e.get_description(ctx);
		s += "\n";
	
	return (s);
	
	
