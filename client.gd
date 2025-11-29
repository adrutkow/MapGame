extends Node3D
class_name Client;

static var client_instance: Client
var nation: Nation = null;

func _ready() -> void:
	Client.client_instance = self;
	nation = GameInstance.game_instance.get_nations()[0];

func get_ui_manager() -> UIManager:
	return $"../UI";
