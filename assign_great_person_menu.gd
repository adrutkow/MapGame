extends UIElement
class_name MenuAssignGreatPerson;

static var instance: MenuAssignGreatPerson;

func _ready() -> void:
	instance = self;

func update():
	var icon_slot_container: IconSlotContainer;
	
	icon_slot_container = $ScrollContainer/IconSlotContainer;
	icon_slot_container.reset_icons();
	for g: GreatPersonData in GameGlobal.gp_data_list.gp_list:
		icon_slot_container.add_icon(g.gp_name, [UIElement.UI_CONTEXT.ASSIGN_GREAT_PERSON]);




func toggle():
	visible = !visible;
	if (visible):
		update();
