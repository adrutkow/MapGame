extends CanvasLayer
class_name UIManager;

static var instance: UIManager;
var selected_army_id: int = -1;
var selected_province: int = -1;

func _init() -> void:
	instance = self;

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Space")):
		GameInstance.game_instance.tick();
	if (Input.is_action_just_pressed("test")):
		add_province_buy_prompt(65);
		
	
	
	
	$FloatingText.position = get_viewport().get_mouse_position();

func tick():
	update_resources();
	update_nation_info();
	update_day(GameInstance.game_instance.day);
	
func on_clicked_province(province_id: int):
	var armies_in_province: Array[int];
	
	selected_province = province_id;
	show_province_info(province_id);
	
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
	
	if (province_id != -1):
		var p: ProvinceState = GameInstance.game_instance.get_province_by_id(province_id);
		p.add_great_person("gp_antonian-immigrants");
		
func show_province_info(province_id: int):
	var province_data: ProvinceData;
	var province_owner: Nation = null;
	
	if (province_id == -1):
		$Control/Province.visible = false;
		return;
		
	province_owner = GameInstance.game_instance.get_province_owner(province_id);
		
	province_data = Map.map_instance.get_province_data_by_id(province_id);
	$Control/Province.visible = true;
	$Control/Province.visible = true;
	$Control/Province/RichTextLabel.text = province_data.name;
	$Control/Province/RichTextLabel2.text = "ocean access: " + str(province_data.ocean_access);
	$Control/Province/RichTextLabel3.text = "river access: " + str(province_data.river_access);
	$Control/Province/ProvinceID.text = str(province_data.id);
	$Control/Province/ProvinceBuildings.display_province_buildings(province_id);
	$Control/Province/ProvinceGreatPeople.display_province_gp(province_id);
	if (province_owner):
		$Control/Province/OwnerText.text = "Owner: " + str(province_owner.nation_name);
	else:
		$Control/Province/OwnerText.text = "Owner: " + "None";
		
		
func add_province_buy_prompt(province_id: int):
	var temp: UIProvincePurchasePrompt = $ProvincePurchase/ProvincePurchasePrompt.duplicate();
	var pos: Vector2;
	
	pos = get_province_ui_position(province_id);
	temp.global_position = pos;
	temp.target_province = province_id;
	
	$ProvincePurchase.add_child(temp);
	
	
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
	update_gold(nation.gold);
	
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

func update_gold(i: int):
	$Control/Mana/VBoxContainer/Gold/RichTextLabel.text = str(i);

func update_day(i: int):
	$Control/Time/RichTextLabel.text = "Day " + str(i);

func activate_floating_text(s: String):
	$FloatingText.visible = true;
	$FloatingText/RichTextLabel.text = s;
	
func disable_floating_text():
	$FloatingText.visible = false;
	
func get_province_ui_position(province_id: int) -> Vector2:
	var pos: Vector2;
	var world_pos: Vector3;
	var screen_pos: Vector2;
	
	pos = Map.map_instance.get_province_center(province_id);
	world_pos = Map.bitmap_vector_to_world(pos);
	screen_pos = $"../Camera3D".unproject_position(world_pos);
	return (screen_pos);
	
	
