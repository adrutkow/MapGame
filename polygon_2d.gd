extends Polygon2D

@export var texture2d: Texture2D;

func _ready() -> void:
	var bitmap: BitMap;
	var t: Texture2D;
	
	var image = texture2d.get_image();

	#image = Image.create(t.get_width(), t.get_height(), false, Image.FORMAT_RGBA8);
	image = texture2d.get_image();
	bitmap = BitMap.new();
	
	#bitmap.create_from_image_alpha(image, 0.5);
	
	
	bitmap.create(image.get_size());
	
	var b: int = 0;
	var w: int = 0;
	
	for y in range(0, image.get_height()):
		for x in range(0, image.get_width()):
			#if (image.get_pixel(x, y).r == 251):
			#	bitmap.set_bit(x, y, true);
			pass;
			
			#
			#if (bitmap.get_bit(x, y) == true):
				#b += 1;
			#else:
				#w += 1;
	
	print(b);
	print(w);
	
	var p
	
	print(bitmap.get_size());
	p = bitmap.opaque_to_polygons(Rect2i(0, 0, bitmap.get_size().x, bitmap.get_size().y), 0.1);
	#polygon.polygon.append_array(p);
	#print(p)
	#print(polygon.polygon)
	#for i in range(0, len(p.get(0))):
		#var zz = p.get(0)[i];
		#polygon.polygon.append(zz);
		#print(zz)
	#polygon.polygon = p.get(0);
	#print(polygon.polygon)
	polygon = p.get(0);
	print(p)
	print(polygon)
