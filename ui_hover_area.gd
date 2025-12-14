extends UIElement
class_name UIHoverArea;

@export var target: UIElement;


func _on_mouse_entered() -> void:
	if (target):
		target.on_hovered();


func _on_mouse_exited() -> void:
	if (target):
		target.on_unhovered();
