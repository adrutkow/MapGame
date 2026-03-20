extends Resource
class_name Cost;

@export var currency_name: String = "currency_default";
@export var amount: float = 0.0;

func get_currency_name() -> String:
	return (GameGlobal.get_currency_data_by_name(currency_name).get_display_name_with_icon());

func get_amount(nation: Nation = null) -> float:
	return (amount);

func generate_description(nation: Nation = null) -> String:
	var a: float;
	var c: CurrencyData;
	var n: String = "?";
	
	c = GameGlobal.get_currency_data_by_name(currency_name);
	if (c):
		n = c.get_display_name_with_icon();
	a = get_amount(nation);
	
	return (n + " " + str(a));
