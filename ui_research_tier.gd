extends Control
class_name UIReasearchTier;

@export var tier: int = 1;
@export var icon_slot_container: IconSlotContainer;
@export var tier_text: RichTextLabel;

func _ready() -> void:
	update();
	
func update():
	icon_slot_container.reset_icons();
	
	for t: TechData in GameGlobal.tech_data_list.tech_list:
		if (t.tier == tier):
			icon_slot_container.add_icon(t.tech_name, [UIElement.UI_CONTEXT.RESEARCH]);

	if (tier_text):
		tier_text.text = "Tier " + str(tier);
