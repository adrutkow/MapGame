extends Control
class_name IconSlotContainer;

@export var icon_slot_prefab: PackedScene;

func _ready() -> void:
	icon_slot_prefab = preload("res://Prefabs/icon_slot.tscn");

func reset_icons():
	for i in get_children():
		if (i is IconSlot):
			i.queue_free();

func add_icon(n: String, ui_context: Array[UIElement.UI_CONTEXT] = []):
	var temp: IconSlot;
	
	temp = icon_slot_prefab.instantiate();
	temp.key = n;
	temp.update();
	temp.visible = true;
	for u: UIElement.UI_CONTEXT in ui_context:
		temp.ui_context.append(u);
	add_child(temp);
