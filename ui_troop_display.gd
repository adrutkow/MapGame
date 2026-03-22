extends UIElement
class_name UITroopDisplay;

@export var key: String = "";
var troop_count: int = 0;

func update():
	var troop_data: TroopData;
	
	troop_data = GameGlobal.get_troop_data_by_name(key);
	if (not troop_data):
		return;
	update_troop_name(troop_data.display_name);
	update_troop_icon(troop_data.troop_icon);
	update_troop_power(troop_data.troop_power);
	update_troop_count(troop_count);
	
func update_troop_name(n: String):
	$HBoxContainer/TroopName.text = n;

func update_troop_power(f: float):
	$HBoxContainer/TroopPower.text = str(f);

func update_troop_count(i: int):
	$HBoxContainer/TroopCount.text = str(i);
	
func update_troop_icon(texture: Texture2D):
	$HBoxContainer/TroopIcon.texture = texture;
