extends Resource
class_name TroopData;

@export var troop_name: String = "troop_default";
@export var display_name: String = "Default troop";
@export var troop_icon: Texture2D;
@export var troop_power: float = 1;
@export var troop_costs: Array[Cost];
@export var troop_maintenance: Array[Cost];
