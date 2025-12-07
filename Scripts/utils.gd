extends Node

var rng: RandomNumberGenerator;

func _ready() -> void:
	rng = RandomNumberGenerator.new();

func wait(time: float) -> bool:
	await get_tree().create_timer(time).timeout
	return (true);

func get_highest_bit(bitmap: BitMap) -> int:
	for y in range(0, bitmap.get_size()[1]):
		for x in range(0, bitmap.get_size()[0]):
			if bitmap.get_bit(x, y):
				return y
	return (-1);
	
func get_lowest_bit(bitmap: BitMap) -> int:
	for y in range(bitmap.get_size()[1] - 1 , -1, -1):
		for x in range(0, bitmap.get_size()[0]):
			if bitmap.get_bit(x, y):
				return (y);
	return (-1);

func get_leftmost_bit(bitmap: BitMap) -> int:
	for x in range(0, bitmap.get_size()[0]):
		for y in range(0, bitmap.get_size()[1]):
			if bitmap.get_bit(x, y):
				return (x);
	return (-1);

func get_rightmost_bit(bitmap: BitMap) -> int:
	for x in range(bitmap.get_size()[0] - 1, -1, -1):
		for y in range(0, bitmap.get_size()[1]):
			if bitmap.get_bit(x, y):
				return (x);
	return (-1);

func get_bitmap_top_left(bitmap: BitMap) -> Vector2i:
	var v: Vector2i = Vector2i(-1, -1);
	var up: int = get_highest_bit(bitmap);
	var left: int = get_leftmost_bit(bitmap);
	
	if (up == -1 or left == -1):
		return (v);
		
	v = Vector2i(left, up);
	
	return (v);

func get_bitmap_center(bitmap: BitMap) -> Vector2i:
	var v: Vector2i = Vector2i(-1, -1);
	var up: int = get_highest_bit(bitmap);
	var down: int = get_lowest_bit(bitmap);
	var left: int = get_leftmost_bit(bitmap);
	var right: int = get_rightmost_bit(bitmap);
	var x: int;
	var y: int;
	
	if (up == -1 or down == -1 or left == -1 or right == -1):
		print("FAKE")
		return (v);
		
	x = abs(right - left) / 2;
	y = abs(down - up) / 2;
	v = Vector2i(-x, -y);
	
	var top_left = Vector2i(left, up);
	var offset = Vector2i(x, y);
	
	return (top_left + offset);
	
