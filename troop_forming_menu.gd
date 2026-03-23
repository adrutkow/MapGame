extends UIElement
class_name MenuTroopForming;

@export var troop_display_prefab: PackedScene;
@export var parent: Control;

func update():
	for c: Control in parent.get_children():
		c.queue_free();
	
	var army: Army;
	
	army = UIManager.instance.get_current_selected_army();
	if (not army):
		return;
	for troop_name: String in army.get_trainable_troops():
		var temp: UITroopDisplay;
		var troop_data: TroopData;
		
		troop_data = GameGlobal.get_troop_data_by_name(troop_name);
		if (not troop_data):
			continue;
		temp = troop_display_prefab.instantiate();
		temp.key = troop_data.troop_name;
		temp.ui_context.append(UI_CONTEXT.FORM_TROOP);
		temp.update();
		parent.add_child(temp);
