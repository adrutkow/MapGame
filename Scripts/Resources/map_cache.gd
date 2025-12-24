extends Resource
class_name MapCache;

@export var province_centers: Array[Vector2i];

func _init() -> void:
	province_centers = [];
