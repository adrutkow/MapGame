extends UIElement
class_name MenuBuyBuilding

static var instance: MenuBuyBuilding;

func _ready() -> void:
	instance = self;

func update():
	var icon_slot_container: IconSlotContainer;
	
	icon_slot_container = $ScrollContainer/IconSlotContainer;
	icon_slot_container.reset_icons();
	for b: ProvinceBuildingData in GameGlobal.province_building_data_list.building_list:
		icon_slot_container.add_icon(b.building_name, [UIElement.UI_CONTEXT.BUY_BUILDING]);

func toggle():
	visible = !visible;
	if (visible):
		update();
