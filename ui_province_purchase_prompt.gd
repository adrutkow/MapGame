extends UIElement
class_name UIProvincePurchasePrompt;

var target_province: int = -1;
var price: int = 1000;

func _physics_process(delta: float) -> void:
	update();

func on_pressed():
	Player.instance.buy_province(target_province);
	UIManager.instance.reset_province_buy_prompts();
	
func update():
	if (target_province == -1):
		return;
	$RichTextLabel.text = "PRICE:\n" + str(price) + Utils.ui_icon_gold();
	global_position = UIManager.instance.get_province_ui_position(target_province);

func _on_button_pressed() -> void:
	on_pressed();
