extends Node3D
class_name Map;

@export var heatmap: Texture2D;
var heatmap_image: Image;
var heatmap_image_texture: ImageTexture;
static var map_instance: Map;
var heatmap_size: Vector2;
var selected_province_id: int = -1;

func _enter_tree() -> void:
	Map.map_instance = self;
	heatmap_image = heatmap.get_image();
	heatmap_image_texture = ImageTexture.create_from_image(heatmap_image);
	heatmap_size = heatmap.get_size();

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
	
func generate_image():
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
	return (image);

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

func generate_bitmap(colors: Array[Color] = [], nations: Array[int] = []):
	var bitmap: BitMap = get_empty_bitmap();
	var temp_c: Color;
	var valid_colors: Array[Color];
	
	for c: Color in colors:
		valid_colors.append(c);
		
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
		
	var center: Vector2i;
	
	center = get_province_center(province_id);
	$"../MeshInstance3D".position = Vector3(center.x / 10, 0, center.y / 10)
	
		
func unselect_province():
	$"../UI/Control/Province".visible = false;

func get_province_center(province_id: int):
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
	return (Utils.get_bitmap_center(bitmap));


static func is_vector3_color(v: Vector3i, c: Color) -> bool:
	return ((v.x == c.r8) and (v.y == c.g8) and (v.z == c.b8));

static func color_to_vector3i(c: Color) -> Vector3i:
	return (Vector3i(c.r8, c.g8, c.b8));

static func vector3i_to_color(v: Vector3i) -> Color:
	return (Color8(v.x, v.y, v.z));
