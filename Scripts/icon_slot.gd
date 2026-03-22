extends UIElement
class_name IconSlot;

@export var key: String = "";
@export var empty_texture: Texture2D;
@export var unknown_texture: Texture2D;

func update():
	if (key.is_empty()):
		set_texture(null);
		return;
	if ("buy_" in key):
		set_texture(load("res://Assets/UI/icon_add.png"));
	if ("building_" in key):
		var building_data: ProvinceBuildingData = GameGlobal.get_province_building_data_by_name(key);
		if (building_data):
			set_texture(building_data.icon);
		return;
	if ("tech_" in key):
		var tech_data: TechData = GameGlobal.get_tech_data_by_name(key);
		if (tech_data):
			set_texture(tech_data.icon);
		return;
	if ("gp_" in key):
		var gp_data: GreatPersonData = GameGlobal.get_great_person_data_by_name(key);
		if (gp_data):
			set_texture(gp_data.icon);
		return;
	set_texture(unknown_texture);


func set_texture(texture: Texture2D = null):
	$IconTexture.texture = texture;
	
func on_hovered():
	var s: String;
	
	s = get_hover_text();
	if (s.is_empty()):
		return;
	UIManager.instance.activate_floating_text(s);
	
func on_unhovered():
	UIManager.instance.disable_floating_text();

func on_pressed():
	if (UIElement.UI_CONTEXT.RESEARCH in get_ui_context()):
		DevConsole.instance.add_line("RESEARCH!");
	if (UIElement.UI_CONTEXT.BUY in get_ui_context()):
		var province_id: int;
		var building_name: String;
		
		if ("buy_" in key):
			MenuBuyBuilding.instance.toggle();
			return;
		
		province_id = UIManager.instance.get_selected_province();
		building_name = key;
		DevConsole.instance.add_line("BUY BUILDING!");
		Player.instance.buy_building(province_id, building_name);
		
	if (UIElement.UI_CONTEXT.SELECT_GREAT_PERSON in get_ui_context()):
		MenuAssignGreatPerson.instance.prompt();
		
	if (UIElement.UI_CONTEXT.ASSIGN_GREAT_PERSON in get_ui_context()):
		var province_id: int;
		var army_id: int;
		var great_person_name: String;
		
		army_id = UIManager.instance.selected_army_id;
		if (army_id != -1):
			if (MenuArmyView.instance.visible):
				var army: Army;
				
				army = GameInstance.game_instance.get_army_by_id(army_id);
				army.general = key;
				MenuArmyView.instance.update();
				return;
		
		province_id = UIManager.instance.get_selected_province();
		great_person_name = key;
		if (province_id != -1):
			GameInstance.game_instance.get_province_by_id(province_id).add_great_person(great_person_name)
			UIManager.instance.show_province_info(province_id);

func _on_button_pressed() -> void:
	on_pressed();

func get_hover_text() -> String:
	var effect_context: EffectContext;
	
	if (key.is_empty()):
		return ("");
	effect_context = EffectContext.new();
	if ("building_" in key):
		var building_data: ProvinceBuildingData = GameGlobal.get_province_building_data_by_name(key);
		if (building_data):
			return (building_data.get_description(effect_context));
	if ("tech_" in key):
		var tech_data: TechData = GameGlobal.get_tech_data_by_name(key);
		if (tech_data):
			return (tech_data.get_description(effect_context));
	if ("gp_" in key):
		var gp_data: GreatPersonData = GameGlobal.get_great_person_data_by_name(key);
		if (gp_data):
			return (gp_data.get_description(effect_context));
	return ("");


func _on_mouse_entered() -> void:
	on_hovered();


func _on_mouse_exited() -> void:
	on_unhovered();
