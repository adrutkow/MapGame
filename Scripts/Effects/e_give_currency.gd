extends Effect
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
	var currency_data: CurrencyData;
	var c_name: String = "?";
	
	if (not ctx):
		return ("Invalid context");
	currency_data = GameGlobal.get_currency_data_by_name(currency_name);
	if (currency_data):
		c_name = currency_data.get_display_name_with_icon();
	if (ctx.nation):
		nation_name = ctx.nation.nation_name;
	if (daily):
		return ("Receive +" + str(intensity) + c_name + " per day");
	return ("Receive +" + str(intensity) + c_name);
	#return (nation_name + " receives +" + str(intensity) + " gold");
