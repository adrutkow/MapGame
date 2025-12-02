extends Node3D
class_name Map;

@export var heatmap: Texture2D;
var heatmap_image: Image;
var heatmap_image_texture: ImageTexture;
static var map_instance: Map;
var heatmap_size: Vector2;
var selected_province_id: int = -1;
var cached_province_centers: Array[Vector2i];

var mesh: ImmediateMesh;
var mat: ORMMaterial3D;

var test: int = 0;

func _enter_tree() -> void:
	Map.map_instance = self;
	heatmap_image = heatmap.get_image();
	heatmap_image_texture = ImageTexture.create_from_image(heatmap_image);
	heatmap_size = heatmap.get_size();

func _ready() -> void:
	init_cache();
	mesh = ImmediateMesh.new();
	mat = ORMMaterial3D.new();
	#generate_mapview_nation_names();
	#generate_mapview_province_names();
	generate_mapview_province_ids();
	#generate_mapview_connections();
	#generate_mapview_diplomacy();
	
func init_cache():
	for i in range(0, len(GameGlobal.province_data_list.province_list)):
		cached_province_centers.append(Vector2i(-1, -1));
	
func get_heatmap_image() -> Image:
	return (heatmap_image);
	
func get_heatmap_image_texture() -> ImageTexture:
	return (heatmap_image_texture);

func get_heatmap_size() -> Vector2:
	return (heatmap_size);

func get_empty_bitmap() -> BitMap:
	var output: BitMap;
	
	output = BitMap.new();
	output.create(heatmap.get_size());
	return (output);
	


func get_nation_by_heatmap_color(c: Color) -> Nation:
	var pd: ProvinceData;
	
	if (not GameInstance.game_instance):
		return (null);
	pd = get_province_data_by_color(c);
	if (not pd):
		return (null);
	for n: Nation in GameInstance.game_instance.get_nations():
		if (pd.id in n.owned_provinces):
			return (n);
	return (null);

func generate_bitmap(colors: Array[Color] = [], nations: Array[int] = [], provinces: Array[int] = []):
	var bitmap: BitMap = get_empty_bitmap();
	var temp_c: Color;
	var valid_colors: Array[Color];
	var nation: Nation;
	var p: ProvinceData;
	
	for c: Color in colors:
		valid_colors.append(c);
		
	for i: int in nations:
		nation = GameInstance.game_instance.get_nations()[i];
		for j: int in nation.owned_provinces:
			p = GameGlobal.province_data_list.province_list[j];
			valid_colors.append(vector3i_to_color(p.heatmap_color));
		
	for pid: int in provinces:
		if (pid < 0):
			continue;
		p = GameGlobal.province_data_list.province_list[pid];
		valid_colors.append(vector3i_to_color(p.heatmap_color));
		
	for y in range(0, heatmap_image.get_height()):
		for x in range(0, heatmap_image.get_width()):
			temp_c = heatmap_image.get_pixel(x, y);
			if (temp_c in valid_colors):
				bitmap.set_bit(x, y, true);
				
	return (bitmap);

func get_province_data_by_color(c: Color) -> ProvinceData:
	for p: ProvinceData in GameGlobal.province_data_list.province_list:
		if (p.heatmap_color.x == c.r8):
			if (p.heatmap_color.y == c.g8):
				if (p.heatmap_color.z == c.b8):
					return (p);
	return (null);

func get_province_data_by_id(i: int) -> ProvinceData:
	for p: ProvinceData in GameGlobal.province_data_list.province_list:
		if (p.id == i):
			return (p);
	return (null);

func select_province(province_id: int):
	if (province_id == -1):
		unselect_province();
		return;
	$"../UI/Control/Province".visible = true;
	$"../UI/Control/Province/RichTextLabel".text = get_province_data_by_id(province_id).name;
	$"../UI/Control/Province/RichTextLabel2".text = "ocean access: " + str(get_province_data_by_id(province_id).ocean_access);
	$"../UI/Control/Province/RichTextLabel3".text = "river access: " + str(get_province_data_by_id(province_id).river_access);
	$"../UI/Control/Province/ProvinceID".text = str(get_province_data_by_id(province_id).id);
		
	return;
		
	var center: Vector2i;
	
	center = get_province_center(province_id);
	var top_left = get_province_top_left(province_id);
	$"../MeshInstance3D".global_position = Vector3(center.x / 100, 0, center.y / 100);
	$"../MeshInstance3D".position = Vector3(float(top_left[0]) / 100.0, 0.0, float(top_left[1]) / 100.0)
	$"../MeshInstance3D2".position = Vector3(float(center[0]) / 100.0, 0.0, float(center[1]) / 100.0)
	var temp: Label3D = $"../Label3D".duplicate();
	temp.text = GameGlobal.province_data_list.province_list[province_id].name;
	temp.position = Vector3(float(center[0]) / 100.0, 0.0, float(center[1]) / 100.0);
	$"../Node3D".add_child(temp);
		
func unselect_province():
	$"../UI/Control/Province".visible = false;

func get_province_top_left(province_id: int):
	var province: ProvinceData = null;
	var c: Color;
	var bitmap: BitMap;
	
	for p: ProvinceData in GameGlobal.province_data_list.province_list:
		if (p.id == province_id):
			province = p;
			break;
	if (not province):
		return (null);
	bitmap = generate_bitmap([vector3i_to_color(province.heatmap_color)]);
	return (Utils.get_bitmap_top_left(bitmap));

func get_province_center(province_id: int):
	var province: ProvinceData = null;
	var c: Color;
	var bitmap: BitMap;
	var output: Vector2i;
	
	if (cached_province_centers[province_id].x != -1):
		print("used cache")
		return (cached_province_centers[province_id]);
	
	for p: ProvinceData in GameGlobal.province_data_list.province_list:
		if (p.id == province_id):
			province = p;
			break;
	if (not province):
		return (null);
	bitmap = generate_bitmap([vector3i_to_color(province.heatmap_color)]);
	output = Utils.get_bitmap_center(bitmap)
	Map.map_instance.cached_province_centers[province_id] = output;
	return (output);

func get_nation_center(nation_id: int):
	var bitmap: BitMap;
	
	bitmap = generate_bitmap([], [nation_id]);
	return (Utils.get_bitmap_center(bitmap));
	
func generate_mapview_diplomacy():
	var image: Image;
	var n: Nation = null;
	var c: Color;
	var pixel_color: Color = Color.BLACK;
	var nation_color: Color = Color.TRANSPARENT;
	image = Image.create_empty(heatmap_image.get_width(), heatmap_image.get_height(), false, Image.FORMAT_RGBA8);
		
	for y in range(0, heatmap_image.get_height()):
		for x in range(0, heatmap_image.get_width()):
			if (pixel_color != heatmap_image.get_pixel(x, y)):
				n = get_nation_by_heatmap_color(heatmap_image.get_pixel(x, y));
				pixel_color = heatmap_image.get_pixel(x, y);
			if (n):
				c = n.nation_color;
				c.a8 = 100;
				image.set_pixel(x, y, c);
	$MapViews/Nations.texture = ImageTexture.create_from_image(image);
	
func generate_mapview_nation_names():
	var center: Vector2;
	var temp: Label3D;
	
	for n: Nation in GameInstance.game_instance.get_nations():
		center = get_nation_center(n.get_nation_id());
		temp = $MapViews/NationNames/NationNameLabel.duplicate();
		temp.modulate = n.nation_color;
		temp.position = Vector3(float(center[0]) / 100.0, 0.0, float(center[1]) / 100.0);
		temp.text = n.nation_name;
		$MapViews/NationNames.add_child(temp);
	
func generate_mapview_province_ids():
	var center: Vector2i;
	var temp: Label3D;
	
	for i in range(0, len(GameGlobal.province_data_list.province_list)):
		center = get_province_center(i);
		temp = $MapViews/ProvinceIDs/ProvinceIDLabel.duplicate();
		temp.position = Vector3(float(center[0]) / 100.0, 0.0, float(center[1]) / 100.0);
		temp.text = str(i);
		$MapViews/ProvinceIDs.add_child(temp);

func generate_mapview_province_names():
	var center: Vector2i;
	var temp: Label3D;
	
	for i in range(0, len(GameGlobal.province_data_list.province_list)):
		center = get_province_center(i);
		temp = $MapViews/ProvinceNames/ProvinceNameLabel.duplicate();
		temp.position = Vector3(float(center[0]) / 100.0, 0.0, float(center[1]) / 100.0);
		temp.text = GameGlobal.province_data_list.province_list[i].name;
		$MapViews/ProvinceNames.add_child(temp);

func generate_mapview_connections():
	var center: Vector2i;
	var center2: Vector2i;
	var temp: MeshInstance3D;
	
	
	for i in range(0, len(GameGlobal.province_data_list.province_list)):
		if (len(GameGlobal.province_data_list.province_list[i].adjacencies) == 0):
			continue;
		center = get_province_center(i);
		temp = $MapViews/ProvinceConnections/ProvinceCenterDot.duplicate();
		temp.position = bitmap_vector_to_world(center) + Vector3(0, 0.05, 0);
		$MapViews/ProvinceConnections.add_child(temp);
		
		for a: int in GameGlobal.province_data_list.province_list[i].adjacencies:
			center2 = get_province_center(a);
			add_line(bitmap_vector_to_world(center) + Vector3(0, 0.05, 0), bitmap_vector_to_world(center2) + Vector3(0, 0.05, 0))

	#for i in range(0, len(GameGlobal.province_data_list.province_list)):
	#	center = get_province_center(i);
	#	add_line(Vector3(0, 1, 0), Vector3(float(center[0]) / 100.0, 0.0, float(center[1]) / 100.0));
	
func generate_mapview_highlighted_provinces(provinces: Array[int]):
	var image: Image;
	var n: Nation = null;
	var c: Color;
	var pixel_color: Color = Color.BLACK;
	var nation_color: Color = Color.TRANSPARENT;
	var bitmap: BitMap;
	
	image = Image.create_empty(heatmap_image.get_width(), heatmap_image.get_height(), false, Image.FORMAT_RGBA8);
		
	bitmap = generate_bitmap([], [], provinces);
		
	for y in range(0, bitmap.get_size()[1]):
		for x in range(0, bitmap.get_size()[0]):
			if (bitmap.get_bit(x, y)):
				image.set_pixel(x, y, Color.AQUA);
			#if (pixel_color != heatmap_image.get_pixel(x, y)):
			#	n = get_nation_by_heatmap_color(heatmap_image.get_pixel(x, y));
			#	pixel_color = heatmap_image.get_pixel(x, y);
			#if (n):
			#	c = n.nation_color;
			#	c.a8 = 100;
			#	image.set_pixel(x, y, c);
	$MapViews/HighlightProvinces/Image.texture = ImageTexture.create_from_image(image);
	
func add_line(start_pos: Vector3, end_pos: Vector3):
	var temp: MeshInstance3D;
	
	temp = $MapViews/ProvinceConnections/ProvinceConnectionLine.duplicate();
	temp.mesh = ImmediateMesh.new()
	temp.mesh.clear_surfaces();
	temp.mesh.surface_begin(Mesh.PRIMITIVE_LINES);
	temp.mesh.surface_add_vertex(start_pos)
	temp.mesh.surface_add_vertex(end_pos);
	temp.mesh.surface_end();
	$MapViews/ProvinceConnections.add_child(temp);

func pathfind(prov1: int, prov2: int):
	var adj: Array[int];
	var output: Array[int];
	
	adj = GameGlobal.get_province_adjacencies(prov1);
	
	print(adj)
	
	output = recursive_pathfind([prov1], prov2);
	if (output == [-1]):
		return;
	generate_mapview_highlighted_provinces(output)
	
func pathfind2(prov1: int, prov2: int) -> Array[int]:
	var paths: Array = [];
	var target: int;
	var visited_nodes = [];
	var new_paths: Array = [];
	var output: Array[int];
	
	paths.append([prov1]);
	target = prov2;
	
	while (not paths.is_empty()):
		new_paths = [];
		for path: Array in paths:
			if (path.is_empty()):
				continue;
			visited_nodes.append(path[-1]);
			for adj in GameGlobal.get_province_adjacencies(path[-1]):
				if (adj in visited_nodes):
					continue;
				
				var temp = path.duplicate();
				if (adj == target):
					temp.append(adj);
					for i in temp:
						output.append(i);
					return (output);
				temp.append(adj);
				new_paths.append(temp);
				
		paths = new_paths.duplicate();
		new_paths = [];
	return [];
	
func recursive_pathfind(path: Array[int], target: int):
	if (path.is_empty()):
		return ([-1]);
	var adj: Array[int];
	var temp: Array[int];
	var free_adj: Array[int];
	
	adj = GameGlobal.get_province_adjacencies(path[len(path) - 1]);
	
	test += 1;
	print(test);
	if (test % 100 == 0):
		print(path)
	
	
	for p in adj:
		if (not (p in path)):
			free_adj.append(p);
	
	
	if (free_adj.is_empty()):
		return ([-1]);
	if (path == [-1]):
		return ([-1]);
	if (target in free_adj):
		temp = path.duplicate();
		temp.append(target);
		return (temp);
		
	for p in free_adj:
		var output;
		
		if (p in path):
			continue;
		
		temp = path.duplicate();
		temp.append(p);
		output = recursive_pathfind(temp, target);
		if (output != [-1]):
			return (output);
	return ([-1]);

static func is_vector3_color(v: Vector3i, c: Color) -> bool:
	return ((v.x == c.r8) and (v.y == c.g8) and (v.z == c.b8));

static func color_to_vector3i(c: Color) -> Vector3i:
	return (Vector3i(c.r8, c.g8, c.b8));

static func vector3i_to_color(v: Vector3i) -> Color:
	return (Color8(v.x, v.y, v.z));

static func bitmap_vector_to_world(v: Vector2i) -> Vector3:
	return (Vector3(float(v[0]) / 100.0, 0.0, float(v[1]) / 100.0));
