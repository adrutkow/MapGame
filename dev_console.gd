extends Control
class_name DevConsole

static var instance: DevConsole;

func _ready() -> void:
	instance = self;
	add_line("MapGame console...");
	
func add_line(str: String):
	$VBoxContainer/ScrollContainer/RichTextLabel.text += str;
	$VBoxContainer/ScrollContainer/RichTextLabel.text += "\n";


func _on_connect_to_server_pressed() -> void:
	NetworkManager.connect_to_server("localhost");
	

func _on_host_server_pressed() -> void:
	NetworkManager.host_server();


func _on_send_command_pressed() -> void:
	NetworkManager.send_command_to_host({});


func _on_game_tick_pressed() -> void:
	GameInstance.game_instance.tick();


func _on_host_tick_pressed() -> void:
	GameInstance.game_instance.host_tick();


func _on_start_host_tick_loop_pressed() -> void:
	GameInstance.game_instance.start = true;


func _on_toggle_lag_pressed() -> void:
	GameInstance.game_instance.lag = !GameInstance.game_instance.lag;


func _on_generate_army_pressed() -> void:
	Map.map_instance.generate_mapview_military();


func _on_give_army_troops_pressed() -> void:
	for a: Army in GameInstance.game_instance.get_armies():
		a.add_unit("goon", 100);
