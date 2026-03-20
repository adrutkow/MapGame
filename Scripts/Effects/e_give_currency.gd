extends Resource
class_name EGiveCurrency;

@export var currency_name: String = "currency_default";
@export var intensity: float = 0.0;
@export var daily: bool = false;

func tick(ctx: EffectContext):
	if (not ctx):
		return;
	if (not ctx.nation):
		return;
	ctx.nation.give_gold(intensity);

func get_description(ctx: EffectContext) -> String:
	var nation_name: String = "?";
	
	if (not ctx):
		return ("Invalid context");
	if (ctx.nation):
		nation_name = ctx.nation.nation_name;
	return ("Receive +" + str(intensity) + " gold.");
	#return (nation_name + " receives +" + str(intensity) + " gold");
