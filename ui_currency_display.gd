extends UIElement
class_name UICurrencyDisplay;

@export var key: String = "";
@export var currency_icon: TextureRect;
@export var amount_display: RichTextLabel;

func update():
	var currency_data: CurrencyData;
	
	currency_data = GameGlobal.get_currency_data_by_name(key);
	currency_icon.texture = currency_data.currency_icon;
	
func update_resource_amount(amount: float):
	amount_display.text = str(int(amount));
	
func client_nation_update():
	var nation: Nation = Client.get_nation();
	
	if (not nation):
		return;
	update_resource_amount(nation.get_currency_amount_by_name(key));
