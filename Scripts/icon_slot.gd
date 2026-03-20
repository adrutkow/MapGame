extends UIElement
class_name IconSlot;

@export var key: String = "";

func update():
	if (key.is_empty()):
		return ("");
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
	if (UIElement.UI_CONTEXT.BUY_BUILDING in get_ui_context()):
		var province_id: int;
		var building_name: String;
		
		if ("buy_" in key):
			MenuBuyBuilding.instance.toggle();
			return;
		
		province_id = UIManager.instance.get_selected_province();
		building_name = key;
		DevConsole.instance.add_line("BUY BUILDING!");
		Player.instance.buy_building(province_id, building_name);

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
