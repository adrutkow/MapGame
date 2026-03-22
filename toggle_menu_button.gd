extends Control
class_name ToggleMenuButton;

@export var target: Control;

func _on_button_pressed() -> void:
	if (not target):
		return;
	if (target is UIElement):
		target.update();
	target.visible = !target.visible;
	
