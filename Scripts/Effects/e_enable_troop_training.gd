extends Effect
class_name EEnableTroopTraining;

@export var trainable_troops: Array[String];

func tick(ctx: EffectContext):
	if (not ctx):
		return;
	if (not ctx.nation):
		return;

func get_description(ctx: EffectContext) -> String:
	var nation_name: String = "?";
	var currency_data: CurrencyData;
	var s: String = "";
	var troop_name: String = "?";
	if (not ctx):
		return ("Invalid context");
		
	s += "Enables training following troops:";
	s += "\n";
	for t: String in trainable_troops:
		var troop_data: TroopData;
		
		troop_data = GameGlobal.get_troop_data_by_name(t);
		if (troop_data):
			troop_name = troop_data.display_name;
		s += TextUtils.bb_green_color();
		s += "		";
		s += troop_name;
		s += TextUtils.bb_end_color();
		s += "\n";
	return (s);
	
