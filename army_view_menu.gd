extends UIElement
class_name MenuArmyView;

@export var general_icon_slot: IconSlot;
static var instance: MenuArmyView;

func _ready() -> void:
	instance = self;

func update():
	var icon_slot_container: IconSlotContainer;
	var army_id: int;
	var army: Army;
	
	army_id = UIManager.instance.selected_army_id;
	if (army_id == -1):
		return;
	army = GameInstance.game_instance.get_army_by_id(army_id);
	general_icon_slot.key = army.general;
	general_icon_slot.update();
	icon_slot_container = $ScrollContainer/IconSlotContainer;
	icon_slot_container.reset_icons();

func toggle():
	visible = !visible;
	if (visible):
		update();

func _on_toggle_formation_button_pressed() -> void:
	$TroopForming.update();
	$TroopForming.visible = !$TroopForming.visible
