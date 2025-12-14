extends Camera3D

@export var move_speed := 5.0
@export var look_sensitivity := 0.2

var _rotation := Vector2.ZERO

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _unhandled_input(event):
	#if event is InputEventMouseMotion:
		## Mouse look
		#_rotation.x -= event.relative.y * look_sensitivity
		#_rotation.y -= event.relative.x * look_sensitivity
		#_rotation.x = clamp(_rotation.x, -89, 89)
		#rotation_degrees = Vector3(_rotation.x, _rotation.y, 0)
#
	#if event.is_action_pressed("ui_cancel"):
		## Escape mouse lock
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		on_left_click(event.position)
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		on_right_click(event.position)
		
func _process(delta):
	var dir := Vector3.ZERO
	var s: float = 0.05;
	
	if Input.is_action_pressed("move_forward"):
		position += Vector3(0, 0, -1) * s;
	if Input.is_action_pressed("move_backward"):
		position += Vector3(0, 0, 1) * s;
	if Input.is_action_pressed("move_left"):
		dir -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		dir += transform.basis.x
	if Input.is_action_just_pressed("scroll_up"):
		dir -= transform.basis.z * 1;
	if Input.is_action_just_pressed("scroll_down"):
		dir += transform.basis.z * 1;

	if dir != Vector3.ZERO:
		dir = dir.normalized()
		global_position += dir * move_speed * delta * 5

func raycast_heatmap(mouse_pos: Vector2):
	var space_state = get_world_3d().direct_space_state

	# Create a ray from the camera through the mouse position
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * 1000.0

	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = true
	query.collide_with_bodies = true

	var result = space_state.intersect_ray(query)
	if result.is_empty():
		#Map.map_instance.unselect_province();
		return

	var collider = result["collider"]
	if collider is Area3D:
		var sprite: Sprite3D = collider.get_child(0)
		var local_pos = sprite.to_local(result.position)

		# Convert local 3D hit position to UV (0–1 range)
		var tex: Texture2D = sprite.texture
		if tex == null:
			return (null);
		var img: Image = tex.get_image()

		# Sprite3D draws centered around its origin, so compensate
		var size = tex.get_size()
		var uv = Vector2(
			(local_pos.x / sprite.pixel_size) / size.x + 0.5,
			(-local_pos.y / sprite.pixel_size) / size.y + 0.5
		)

		# Convert UV → pixel coordinates
		var px = int(uv.x * size.x)
		var py = int(uv.y * size.y)

		if px >= 0 and px < size.x and py >= 0 and py < size.y:
			var color = img.get_pixel(px, py)
			return (color);
	return (null);

func on_left_click(mouse_pos: Vector2):
	var color = raycast_heatmap(mouse_pos);
	
	if (not color):
		return;
	
	var p: ProvinceData = Map.map_instance.get_province_data_by_color(color);
	
	if (p):
		#Map.map_instance.select_province(p.id);
		UIManager.instance.on_clicked_province(p.id);
	else:
		UIManager.instance.show_province_info(-1);

func on_right_click(mouse_pos: Vector2):
	var color = raycast_heatmap(mouse_pos);
	
	if (not color):
		return;
	
	var p: ProvinceData = Map.map_instance.get_province_data_by_color(color);
	if (p):
		UIManager.instance.on_right_clicked_province(p.id);
			
