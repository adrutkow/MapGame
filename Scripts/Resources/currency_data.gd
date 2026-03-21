extends Resource
class_name CurrencyData

@export var currency_name: String = "currency_default";
@export var display_name: String = "Default currency";
@export var currency_icon: Texture2D;
@export var description: String;

func get_icon() -> Texture2D:
	if (not currency_icon):
		return (load("res://icon.svg"));
	return (currency_icon);

func get_icon_path() -> String:
	return (get_icon().resource_path);

func get_display_name() -> String:
	return (display_name);

func get_display_icon() -> String:
	return ("[img=16x16]"+ get_icon_path() +"[/img]");

func get_display_name_with_icon() -> String:
	return ("[img=16x16]" + get_icon_path() +"[/img] " + get_display_name());

func get_description() -> String:
	return (description);
