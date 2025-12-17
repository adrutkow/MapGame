extends UIElement
class_name IconSlot;

var key: String = "";

func update():
	if (key.is_empty()):
		return ("");
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
