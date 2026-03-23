extends UIElement
class_name MenuArmyView;

@export var general_icon_slot: IconSlot;
@export var troop_display_prefab: PackedScene;
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
	update_troops(army);

func update_troops(army: Army):
	var troops_display_parent: Control;
	
	troops_display_parent = $TroopList/ScrollContainer/VBoxContainer;
	for c in troops_display_parent.get_children():
		c.queue_free();
	for t: String in army.get_troop_types():
		var temp: UITroopDisplay;
		
		temp = troop_display_prefab.instantiate();
		temp.key = t;
		temp.troop_count = int(army.unit_groups[t]);
		temp.update();
		troops_display_parent.add_child(temp);
		

func toggle():
	visible = !visible;
	if (visible):
		update();

func _on_toggle_formation_button_pressed() -> void:
	$TroopForming.update();
	$TroopForming.visible = !$TroopForming.visible
	update();
