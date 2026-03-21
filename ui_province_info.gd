extends UIElement
class_name UIProvinceInfo;

func update_info():
	$RichTextLabel.text = get_hover_text(UIManager.instance.get_selected_province());

func get_hover_text(province_id: int):
	var province: ProvinceState;
	var s: String;
	
	province = GameInstance.game_instance.get_province_by_id(province_id);
	
	for key in province.last_generated_currency.keys():
		var currency_data: CurrencyData;
		
		currency_data = GameGlobal.get_currency_data_by_name(key);
		s += TextUtils.color_number(province.last_generated_currency[key]);
		s += " " + currency_data.get_display_icon();
		s += "\n";
	
	return (s);

func on_hovered():
	var s: String;
	
	s = get_hover_text(UIManager.instance.get_selected_province());
	if (s.is_empty()):
		return;
	UIManager.instance.activate_floating_text(s);
