extends UIElement
class_name UIMana;

@export var currency_display_prefab: PackedScene;
@export var currency_display_parent: Control;

func _ready() -> void:
	currency_display_prefab = preload("res://Prefabs/currency_display.tscn");
	
	for c: CurrencyData in GameGlobal.currency_data_list.list:
		var temp: UICurrencyDisplay;
		
		temp = currency_display_prefab.instantiate();
		temp.key = c.currency_name;
		temp.update();
		currency_display_parent.add_child(temp);
