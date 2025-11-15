extends Node3D
class_name Map;

@export var heatmap: Texture2D;
var heatmap_image: Image;
var heatmap_image_texture: ImageTexture;
static var map_instance: Map;
var heatmap_size: Vector2;

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
