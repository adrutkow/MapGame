extends Sprite3D

@export var polygon: CSGPolygon3D;

var current_i: int = 250;

func _ready() -> void:
	pass;
	#var bitmap: BitMap;
	#var t: Texture2D;
	#var image: Image;
	#
	#t = $".".texture;
	##image = Image.create(t.get_width(), t.get_height(), false, Image.FORMAT_RGBA8);
	#image = t.get_image();
	#bitmap = BitMap.new();
	#
	##bitmap.create_from_image_alpha(image, 0.5);
	#
	#bitmap.create(image.get_size());
	#
	#var b: int = 0;
	#var w: int = 0;
	#
	#for y in range(0, image.get_height()):
		#for x in range(0, image.get_width()):
			#if (image.get_pixel(x, y).r8 == 252):
				#bitmap.set_bit(x, y, true);
			#else:
				#bitmap.set_bit(x, y, false);
#
	#
	#print(b);
	#print(w);
	#
	#var p
	#print(bitmap.get_size());
	#p = bitmap.opaque_to_polygons(Rect2i(0, 0, bitmap.get_size().x, bitmap.get_size().y), 0.1);
#
	#polygon.polygon = p.get(0);
	
func _process(delta: float) -> void:
	pass;
	
func highlight_by_color(color: Color):
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
			#bitmap.set_bit(x, y, true);
			#if (bitmap.get_bit(x, y) == true):
				#b += 1;
			#else:
				#w += 1;
	#var p
	print(bitmap.get_size());
	#p = bitmap.opaque_to_polygons(Rect2i(0, 0, bitmap.get_size().x, bitmap.get_size().y), 0.1);
	
	var new_image: Image;
	new_image = bitmap.convert_to_image();
	print(new_image)
	
	
	
	$"../../HighlightedProvince/NewImage".texture = ImageTexture.create_from_image(new_image);
	$"../../HighlightedProvince/NewImage/NewImage2".texture = ImageTexture.create_from_image(new_image);
	

	# Assign the Sprite3D's texture to its shader at runtime
	var sprite3d: Sprite3D = $"../../HighlightedProvince/NewImage";
	var sprite3d2: Sprite3D = $"../../HighlightedProvince/NewImage/NewImage2";
	
	var mat = sprite3d.material_override as ShaderMaterial
	if mat and sprite3d.texture:
		mat.set_shader_parameter("albedo_texture", sprite3d.texture)
	
	mat = sprite3d2.material_override as ShaderMaterial
	if mat and sprite3d2.texture:
		mat.set_shader_parameter("albedo_texture", sprite3d2.texture)
	
	#if (not p):
	#	return;
	#polygon.polygon = p.get(0);
	
	
	#
#func swap(i: int = 1):
	#var bitmap: BitMap;
	#var t: Texture2D;
	#var image: Image;
	#
	#t = $".".texture;
	##image = Image.create(t.get_width(), t.get_height(), false, Image.FORMAT_RGBA8);
	#image = t.get_image();
	#bitmap = BitMap.new();
	#
	##bitmap.create_from_image_alpha(image, 0.5);
	#
	#bitmap.create(image.get_size());
	#
	#var b: int = 0;
	#var w: int = 0;
	#
	#for y in range(0, image.get_height()):
		#for x in range(0, image.get_width()):
			#if (image.get_pixel(x, y).r8 == current_i):
				#bitmap.set_bit(x, y, true);
			#else:
				#bitmap.set_bit(x, y, false);
			##bitmap.set_bit(x, y, true);
			##if (bitmap.get_bit(x, y) == true):
				##b += 1;
			##else:
				##w += 1;
	#
	#print(b);
	#print(w);
	#
	#current_i += i;
	#if (current_i > 255):
		#current_i = 255;
	#
	#var p
	#print(bitmap.get_size());
	#p = bitmap.opaque_to_polygons(Rect2i(0, 0, bitmap.get_size().x, bitmap.get_size().y), 0.01);
	##polygon.polygon.append_array(p);
	##print(p)
	##print(polygon.polygon)
	##for i in range(0, len(p.get(0))):
		##var zz = p.get(0)[i];
		##polygon.polygon.append(zz);
		##print(zz)
	#if (not p):
		#return;
	#polygon.polygon = p.get(0);
	
	
