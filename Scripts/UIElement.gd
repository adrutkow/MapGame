extends Control
class_name UIElement;

enum UI_CONTEXT
{
	RESEARCH,
	PROVINCE_BUILDINGS,
	BUY_PROVINCE,
}

@export var ui_context: Array[UI_CONTEXT] = [];

func on_hovered():
	pass;

func on_unhovered():
	pass;

func on_pressed():
	pass;

func get_ui_context() -> Array[UI_CONTEXT]:
	return (ui_context);
