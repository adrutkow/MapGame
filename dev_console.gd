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
