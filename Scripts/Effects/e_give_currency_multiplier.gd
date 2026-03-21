extends Effect
class_name EGiveCurrencyMultiplier;

@export var currency_name: String = "currency_default";
@export var percentage: float = 0.0;

func tick(ctx: EffectContext):
	if (not ctx):
		return;
	if (not ctx.nation):
		return;
	#ctx.nation.give_currency(currency_name, intensity);

func get_description(ctx: EffectContext) -> String:
	var nation_name: String = "?";
	var currency_data: CurrencyData;
	var c_name: String = "?";
	
	if (not ctx):
		return ("Invalid context");
	currency_data = GameGlobal.get_currency_data_by_name(currency_name);
	if (currency_data):
		c_name = currency_data.get_display_icon();
	if (ctx.nation):
		nation_name = ctx.nation.nation_name;
	return (c_name + " generated: " +
		TextUtils.color_number(percentage, false, true));
