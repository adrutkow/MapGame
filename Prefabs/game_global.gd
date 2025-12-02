extends Node

@export var heatmap: Texture2D;
@export var nation_data_list: NationDataList;
@export var province_data_list: ProvinceDataList;

func is_valid_province_id(prov_id: int) -> bool:
	if (prov_id >= 0 and prov_id < len(province_data_list.province_list)):
		return (true);
	return (false);

func get_province_adjacencies(prov_id: int):
	if (not is_valid_province_id(prov_id)):
		return ([]);
	return (province_data_list.province_list[prov_id].adjacencies);
