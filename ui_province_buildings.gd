extends Control
class_name UIProvinceBuildings;

func display_province_buildings(province_id: int):
	var province: ProvinceState;
	
	reset_buildings();
	province = GameInstance.game_instance.get_province_by_id(province_id);
	for n: String in province.get_buildings():
		var d: ProvinceBuildingData;
		
		add_building(n);
		#d = GameGlobal.get_province_building_data_by_name(s);
		

func reset_buildings():
	for t in $ScrollContainer/GridContainer.get_children():
		if (t.name != "ProvinceBuildingSlot"):
			t.queue_free();

func add_building(n: String):
	var temp: ProvinceBuildingSlot;
	
	temp = $ScrollContainer/GridContainer/ProvinceBuildingSlot.duplicate();
	temp.building_name = n;
	temp.update();
	temp.visible = true;
	
	$ScrollContainer/GridContainer.add_child(temp);
