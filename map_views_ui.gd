extends Control



func _on_province_names_toggle_pressed() -> void:
	$"../../../Map/MapViews/ProvinceNames".visible = !$"../../../Map/MapViews/ProvinceNames".visible;


func _on_province_ids_toggle_pressed() -> void:
	$"../../../Map/MapViews/ProvinceIDs".visible = !$"../../../Map/MapViews/ProvinceIDs".visible;



func _on_nation_names_toggle_pressed() -> void:
	$"../../../Map/MapViews/NationNames".visible = !$"../../../Map/MapViews/NationNames".visible;


func _on_diplomatic_view_toggle_pressed() -> void:
	$"../../../Map/MapViews/Nations".visible = !$"../../../Map/MapViews/Nations".visible;
