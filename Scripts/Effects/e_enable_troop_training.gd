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
	var c_name: String = "?";
	var s: String = "";
	
	if (not ctx):
		return ("Invalid context");
		
	s += "Enables training following troops:";
	s += "\n";
	for t: String in trainable_troops:
		s += TextUtils.bb_green_color();
		s += "		";
		s += t;
		s += TextUtils.bb_end_color();
		s += "\n";
	return (s);
