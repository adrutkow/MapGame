extends UIElement
class_name UICloseWindow;

@export var target: Control;

func _on_pressed() -> void:
	if (not target):
		return;
	target.visible = false;
