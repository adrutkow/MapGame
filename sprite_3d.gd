extends Sprite3D

var current_i: int = 250;

func _ready() -> void:
	pass;
	
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("right_click"):
		#var list: Array[int];
		#for p: ProvinceData in Map.map_instance.province_data_list.list:
			#if (p.ocean_access):
				#list.append(p.id);
		#highlight_by_id(list);
	if Input.is_action_just_pressed("right_click"):
		var image: Image;
		
		image = Map.map_instance.generate_image();
		$"../../MapViews/Nations".texture = ImageTexture.create_from_image(image);
	
func get_highlight_sprite() -> Sprite3D:
	return ($"../../HighlightedProvince/Highlight");
	
func get_highlight_sprite_shadow() -> Sprite3D:
	return ($"../../HighlightedProvince/Highlight/HighlightShadow");
	
#func generate_empty_bitmap() -> BitMap:
#	pass;
	
func highlight_by_id(arr: Array[int], _c: Color = Color.REBECCA_PURPLE):
	var bitmap: BitMap;
	var t: Texture2D;
	var image: Image;
	var colors: Array[Color];
	
	for i: int in arr:
		for p: ProvinceData in Map.map_instance.province_data_list.list:
			if (p.id == i):
				colors.append(Map.vector3i_to_color(p.heatmap_color));
	
	t = $".".texture;
	image = t.get_image();
	bitmap = BitMap.new();
	bitmap.create(image.get_size());
	
	print(colors);
	
	var temp_c: Color;
	var v: Vector3i;
	for y in range(0, image.get_height()):
		for x in range(0, image.get_width()):
			temp_c = image.get_pixel(x, y);
			if (temp_c in colors):
				bitmap.set_bit(x, y, true);

	print(bitmap.get_size());
	
	var new_image: Image;
	new_image = bitmap.convert_to_image();
	print(new_image)
	
	$"../../HighlightedProvince/Highlight".texture = ImageTexture.create_from_image(new_image);
	$"../../HighlightedProvince/NewImage/NewImage2".texture = ImageTexture.create_from_image(new_image);

	# Assign the Sprite3D's texture to its shader at runtime
	var sprite3d: Sprite3D = $"../../HighlightedProvince/Highlight";
	var sprite3d2: Sprite3D = $"../../HighlightedProvince/NewImage/NewImage2";
	
	var mat = sprite3d.material_override as ShaderMaterial
	if mat and sprite3d.texture:
		mat.set_shader_parameter("albedo_texture", sprite3d.texture)
		mat.set_shader_parameter("c", _c);
	
	mat = sprite3d2.material_override as ShaderMaterial
	if mat and sprite3d2.texture:
		mat.set_shader_parameter("albedo_texture", sprite3d2.texture)
		mat.set_shader_parameter("c", _c);
		
	pass;
	
func highlight_by_color(color: Color, _c: Color = Color.GREEN):
	var bitmap: BitMap;
	var t: Texture2D;
	var image: Image;
	
	if (color.a8 < 255):
		return;
	
	t = $".".texture;
	#image = Image.create(t.get_width(), t.get_height(), false, Image.FORMAT_RGBA8);
	image = t.get_image();
	bitmap = BitMap.new();
	
	#bitmap.create_from_image_alpha(image, 0.5);
	bitmap.create(image.get_size());
	
	for y in range(0, image.get_height()):
		for x in range(0, image.get_width()):
			if (image.get_pixel(x, y) == color):
				bitmap.set_bit(x, y, true);
			else:
				bitmap.set_bit(x, y, false);

	print(bitmap.get_size());
	var new_image: Image;
	new_image = bitmap.convert_to_image();
	print(new_image)
	
	get_highlight_sprite().texture = ImageTexture.create_from_image(new_image);
	get_highlight_sprite_shadow().texture = ImageTexture.create_from_image(new_image);

	# Assign the Sprite3D's texture to its shader at runtime
	var sprite3d: Sprite3D = get_highlight_sprite();
	var sprite3d2: Sprite3D = get_highlight_sprite_shadow();
	
	var mat = sprite3d.material_override as ShaderMaterial
	if mat and sprite3d.texture:
		mat.set_shader_parameter("albedo_texture", sprite3d.texture)
		mat.set_shader_parameter("c", _c);
	
	mat = sprite3d2.material_override as ShaderMaterial
	if mat and sprite3d2.texture:
		mat.set_shader_parameter("albedo_texture", sprite3d2.texture)
		mat.set_shader_parameter("c", _c);
