extends Node3D

var nation_id: int = -1;

func _ready() -> void:
	nation_id = 0;

func get_nation() -> Nation:
	return (GameInstance.game_instance.get_nations()[nation_id]);
	
