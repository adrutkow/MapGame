extends Control
class_name UIProvinceBuildings;

func display_province_buildings(province_id: int):
	var province: ProvinceState;
	
	reset_buildings();
	province = GameInstance.game_instance.get_province_by_id(province_id);
	for n: String in province.get_buildings():
		var d: ProvinceBuildingData;
		
		add_building(n);
		

func reset_buildings():
	var icon_slot_container: IconSlotContainer;
	
	icon_slot_container = $ScrollContainer/IconSlotContainer;
	icon_slot_container.reset_icons();

func add_building(n: String):
	var icon_slot_container: IconSlotContainer;
	
	icon_slot_container = $ScrollContainer/IconSlotContainer;
	icon_slot_container.add_icon(n);
