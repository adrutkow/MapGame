extends Sprite3D

@export var heatmap: Texture2D;


func _ready() -> void:
	var image: Image;
	var image_texture: ImageTexture;
	var heatmap_image: Image;
	var map_size: Vector2;
	image = Image.create_empty(heatmap.get_width(), heatmap.get_height(), false, Image.FORMAT_RGBA8);
	heatmap_image = Map.map_instance.get_heatmap_image();
	map_size = Map.map_instance.heatmap_size;

	for y in range(0, map_size.y):
		for x in range (0, map_size.x):
			if (heatmap_image.get_pixel(x, y).a8 > 100):
				image.set_pixel(x, y, Color.WEB_GREEN);
				#image.set_pixel(x, y, Color.GRA);
				
			if (heatmap_image.get_pixel(x, y) == Color8(255, 216, 0)):
				image.set_pixel(x, y, heatmap_image.get_pixel(x, y));
				#image.set_pixel(x, y, Color.WHITE);


	image_texture = ImageTexture.create_from_image(image);


	texture = image_texture;
