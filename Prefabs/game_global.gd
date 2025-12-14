extends Node

@export var heatmap: Texture2D;
@export var nation_data_list: NationDataList;
@export var province_data_list: ProvinceDataList;
@export var province_building_data_list: ProvinceBuildingDataList;

enum GAME_ACTION {
	UPGRADE_PROVINCE,
}

func is_valid_province_id(prov_id: int) -> bool:
	if (prov_id >= 0 and prov_id < len(province_data_list.province_list)):
		return (true);
	return (false);

func get_province_adjacencies(prov_id: int):
	if (not is_valid_province_id(prov_id)):
		return ([]);
	return (province_data_list.province_list[prov_id].adjacencies);

func get_province_building_data_by_name(n: String) -> ProvinceBuildingData:
	for p: ProvinceBuildingData in province_building_data_list.building_list:
		if (p.building_name == n):
			return (p);
	return (null);
