extends Node3D
class_name Player;

# All player actions should go through here.
static var instance: Player;

func _ready() -> void:
	instance = self;

func buy_province(province_id: int):
	var temp_command: Dictionary;
	var context: Dictionary;
	
	if (province_id == -1):
		return;
	temp_command = NetworkManager.get_default_command();
	temp_command["source"] = Client.get_nation_id();
	temp_command["type"] = NetworkManager.COMMAND_TYPE.BUY_PROVINCE;
	context = {
		"province_id": province_id,
	}
	temp_command["context"] = context;
	send_command(temp_command);

func buy_building(province_id: int, building_name: String):
	var temp_command: Dictionary;
	var context: Dictionary;
	
	if (province_id == -1):
		return;
	temp_command = NetworkManager.get_default_command();
	temp_command["source"] = Client.get_nation_id();
	temp_command["type"] = NetworkManager.COMMAND_TYPE.BUY_BUILDING;
	context = {
		"province_id": province_id,
		"building_name": building_name,
	}
	temp_command["context"] = context;
	send_command(temp_command);

func send_command(command: Dictionary):
	NetworkManager.send_command_to_host(command);
