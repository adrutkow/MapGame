extends UIElement
class_name MenuTroopForming;

@export var troop_display_prefab: PackedScene;
@export var parent: Control;

func update():
	for c: Control in parent.get_children():
		c.queue_free();
	
	for t: TroopData in GameGlobal.troop_data_list.troop_list:
		var temp: UITroopDisplay;
		
		temp = troop_display_prefab.instantiate();
		temp.key = t.troop_name;
		temp.ui_context.append(UI_CONTEXT.FORM_TROOP);
		temp.update();
		parent.add_child(temp);
