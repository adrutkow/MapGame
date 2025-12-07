extends CanvasLayer
class_name UIManager;

static var instance: UIManager;
var selected_army_id: int = -1;


func _init() -> void:
	instance = self;

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Space")):
		GameInstance.game_instance.tick();

func tick():
	update_resources();
	update_nation_info();
	update_day(GameInstance.game_instance.day);
	
func on_clicked_province(province_id: int):
	var armies_in_province: Array[int];
	
	armies_in_province = GameInstance.game_instance.get_army_ids_in_province(province_id);
	if (armies_in_province.is_empty()):
		select_army(-1);
		return;
	if (selected_army_id in armies_in_province):
		var index: int;
		
		index = armies_in_province.find(selected_army_id) + 1;
		if (index >= len(armies_in_province)):
			index = 0;
		select_army(armies_in_province[index]);
	else:
		select_army(armies_in_province[0]);
	
func on_right_clicked_province(province_id: int):
	if (selected_army_id != -1):
		var a: Army = GameInstance.game_instance.get_army_by_id(selected_army_id);
		
		a.desired_path = Map.map_instance.pathfind(a.province_id, province_id);
	
func select_army(army_id: int):
	selected_army_id = army_id;
	Map.map_instance.update_armycube_visual();
	
func get_client_nation() -> Nation:
	return (Client.get_nation());
	
func update_resources():
	var nation: Nation;
	
	nation = Client.get_nation();
	if (not nation):
		return;
	update_science(nation.science);
	update_military(nation.power);
	
func update_nation_info():
	if (not get_client_nation()):
		return;
	update_name(get_client_nation().nation_name);
	
func update_name(s: String):
	$Control/Misc/RichTextLabel.text = s;
	
func update_science(i: int):
	$Control/Mana/VBoxContainer/Science/Control/RichTextLabel.text = str(i);

func update_military(i: int):
	$Control/Mana/VBoxContainer/Power/RichTextLabel.text = str(i);

func update_day(i: int):
	$Control/Time/RichTextLabel.text = "Day " + str(i);
