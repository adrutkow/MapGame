extends Control
class_name WindowDragger;

@export var target: Control;
var dragging: bool = false;
var target_start_position: Vector2;
var mouse_start_position: Vector2;

func _process(delta: float) -> void:
	if (dragging):
		var offset: Vector2;
		
		offset = mouse_start_position - get_global_mouse_position();
		target.global_position = target_start_position - offset;

func _on_gui_input(event: InputEvent) -> void:
	print(event)
	if (event.is_action_pressed("left_click")):
		dragging = true;
		target_start_position = target.global_position;
		mouse_start_position = get_global_mouse_position();
	if (event.is_action_released("left_click")):
		dragging = false;
		
