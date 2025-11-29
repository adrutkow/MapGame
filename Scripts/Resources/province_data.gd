extends Resource
class_name ProvinceData;

@export var name: String;
@export var id: int = -1;
@export var heatmap_color: Vector3i;
@export var ocean_access: bool = false;
@export var river_access: bool = false;
@export var adjacencies: Array[int];
