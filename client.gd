extends Node3D

var nation_id: int = -1;

func _ready() -> void:
	nation_id = 0;

func get_nation() -> Nation:
	return (GameInstance.game_instance.get_nations()[nation_id]);
	
func get_nation_id() -> int:
	return (nation_id);

func change_nation(n: int):
	nation_id = n;
	UIManager.instance.tick();
	
