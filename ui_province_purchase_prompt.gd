extends UIElement
class_name UIProvincePurchasePrompt;

var target_province: int;

func on_pressed():
	var temp_command: Dictionary;
	var context: Dictionary;
	
	temp_command = NetworkManager.get_default_command();
	temp_command["source"] = Client.get_nation_id();
	temp_command["type"] = NetworkManager.COMMAND_TYPE.BUY_PROVINCE;
	context = {
		"province_id": target_province,
	}
	temp_command["context"] = context;
	DevConsole.instance.add_line("Clicked button")
	NetworkManager.send_command_to_host(temp_command);
	
func _on_button_pressed() -> void:
	on_pressed();
