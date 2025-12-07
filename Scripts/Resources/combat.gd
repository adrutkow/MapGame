extends Resource
class_name Combat;

var armies: Array[int];


func tick():
	var side_one: Array[int];
	var side_two: Array[int];
	var side_one_strength: float = 0;
	var side_two_strength: float = 0;
	
	if (len(armies) <= 1):
		stop();
		return;
	
	for i: int in range(0, len(armies)):
		var army: Army = GameInstance.game_instance.get_army_by_id(armies[i]);
		var nation: Nation = GameInstance.game_instance.get_nations()[army.nation_owner_id];
		
		if (army.is_defeated()):
			continue;
		if (i == 0):
			side_one.append(armies[0]);
			continue;
		side_two.append(armies[1]);

	if (len(side_one) == 0 or len(side_two) == 0):
		stop();
		return;

	side_one_strength = get_side_strength(side_one);
	side_two_strength = get_side_strength(side_two);
	
	var diff = abs(side_one_strength - side_two_strength);
	
	if (side_one_strength < side_two_strength):
		for a_id: int in side_one:
			GameInstance.game_instance.get_army_by_id(a_id).lose_unit(50);
	if (side_one_strength > side_two_strength):
		for a_id: int in side_two:
			GameInstance.game_instance.get_army_by_id(a_id).lose_unit(50);
	if (side_one_strength == side_two_strength):
		for a_id: int in side_one:
			GameInstance.game_instance.get_army_by_id(a_id).lose_unit(50);
		for a_id: int in side_two:
			GameInstance.game_instance.get_army_by_id(a_id).lose_unit(50);


	for a_id: int in armies:
		var army: Army = GameInstance.game_instance.get_army_by_id(a_id);
		
		if (army.get_unit_count() <= 0):
			army.defeated = true;

func get_side_strength(side: Array[int]) -> float:
	var output: float = 0;
	
	for i: int in side:
		var army: Army = GameInstance.game_instance.get_army_by_id(i);
		var nation: Nation = GameInstance.game_instance.get_nations()[army.nation_owner_id];

		output += army.get_unit_count();
	return (output);
	
		
func stop():
	var index: int;
	
	index = GameInstance.game_instance.combats.find(self);
	if (index != -1):
		GameInstance.game_instance.combats.remove_at(index);

func get_province_id() -> int:
	var output: int = -1;
	
	if (not armies.is_empty()):
		output = GameInstance.game_instance.get_army_by_id(armies[0]).province_id;
	return (output);
