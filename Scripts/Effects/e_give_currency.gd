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

func get_description(ctx: EffectContext) -> String:
	var nation_name: String = "?";
	var currency_data: CurrencyData;
	var c_name: String = "?";
	var s: String = "";
	
	if (not ctx):
		return ("Invalid context");
	currency_data = GameGlobal.get_currency_data_by_name(currency_name);
	if (currency_data):
		c_name = currency_data.get_display_name_with_icon();
	if (ctx.nation):
		nation_name = ctx.nation.nation_name;
	s += currency_data.get_display_name_with_icon();
	if (daily):
		s += " per day: ";
	s += TextUtils.color_number(intensity);
	return (s);
