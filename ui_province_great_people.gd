extends Control
class_name UIProvinceGreatPeople;

func display_province_gp(province_id: int):
	var province: ProvinceState;
	
	reset_icons();
	province = GameInstance.game_instance.get_province_by_id(province_id);
	for n: String in province.get_great_people():
		add_icon(n);
		
func reset_icons():
	var icon_slot_container: IconSlotContainer;
	
	icon_slot_container = $ScrollContainer/IconSlotContainer;
	icon_slot_container.reset_icons();

func add_icon(n: String):
	var icon_slot_container: IconSlotContainer;
	
	icon_slot_container = $ScrollContainer/IconSlotContainer;
	icon_slot_container.add_icon(n);
