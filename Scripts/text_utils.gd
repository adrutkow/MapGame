extends Node

var white_color: Color;
var green_color: Color;
var red_color: Color;
var yellow_color: Color;
var orange_color: Color;

func _init() -> void:
	white_color = Color.WHITE;
	green_color = Color.LIME_GREEN;
	red_color = Color.DARK_RED;
	yellow_color = Color.YELLOW;
	orange_color = Color.DARK_ORANGE;
	
func bb_white_color() -> String:
	return ("[color=" + white_color.to_html() + "]");
	
func bb_green_color() -> String:
	return ("[color=" + green_color.to_html() + "]");
	
func bb_red_color() -> String:
	return ("[color=" + red_color.to_html() + "]");

func bb_yellow_color() -> String:
	return ("[color=" + yellow_color.to_html() + "]");
	
func bb_orange_color() -> String:
	return ("[color=" + orange_color.to_html() + "]");
	
func bb_end_color() -> String:
	return ("[/color]");
	
func orange_color_text(s: String) -> String:
	var output: String = "";
	
	output += bb_orange_color();
	output += s;
	output += bb_end_color();
	return (output);
	
func effects_text() -> String:
	var output: String = "";
	
	output += bb_orange_color();
	output += "Effects:";
	output += bb_end_color();
	
	return (output);
	
func color_number(n: float, higher_worse: bool = false,
		percent: bool = false) -> String:
	var output: String = "";
	var sign: String = "+";

	if (n < 0):
		sign = "-";

	if (n > 0):
		if (higher_worse):
			output += bb_red_color()
		else:
			output += bb_green_color();
	elif (n == 0):
		output += bb_white_color();
	elif (n < 0):
		if (higher_worse):
			output += bb_green_color()
		else:
			output += bb_red_color();

	output += sign;
	output += str(n);
	if (percent):
		output += "%";
	output += bb_end_color();
	
	return (output);
