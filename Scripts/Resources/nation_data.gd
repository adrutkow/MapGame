extends Resource
class_name NationData;

@export var nation_name: String;
@export var nation_color: Color;
@export var nation_flag: Texture2D;
@export var owned_provinces: Array[int];
@export var start_science: int = 0;
@export var start_culture: int = 0;
@export var start_gold: int = 0;
@export var start_happiness: int = 0;
@export var start_power: int = 0;
