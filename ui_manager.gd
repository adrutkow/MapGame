extends CanvasLayer
class_name UIManager;

func tick():
	update_resources();
	update_nation_info();
	update_day(GameInstance.game_instance.day);
	
func get_client_nation() -> Nation:
	return (Client.client_instance.nation);
	
func update_resources():
	var nation: Nation;
	
	nation = Client.client_instance.nation;
	if (not nation):
		return;
	update_science(nation.science);
	
func update_nation_info():
	if (not get_client_nation()):
		return;
	update_name(get_client_nation().nation_name);
	
func update_name(s: String):
	$Control/Misc/RichTextLabel.text = s;
	
func update_science(i: int):
	$Control/Mana/VBoxContainer/Science/Control/RichTextLabel.text = str(i);

func update_day(i: int):
	$Control/Time/RichTextLabel.text = "Day " + str(i);
