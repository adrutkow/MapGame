extends Resource
class_name Combat;

var attacker_armies: Array[int];
var defender_armies: Array[int];
var combat_width: int = 20;
var attacker_line_troops: Array[int] = [];
var defender_line_troops: Array[int] = [];
var attacker_morale: float = 100;
var defender_morale: float = 100;

func init_combat(attackers: Array[int], defenders: Array[int]):
	attacker_armies.append_array(attackers);
	defender_armies.append_array(defenders);

func tick():
	var attacker_strength: float = 0;
	var defender_strength: float = 0;
	
	if (len(attacker_armies) == 0 or len(defender_armies) == 0):
		stop();
		return;

	attacker_strength = get_side_strength(attacker_armies);
	defender_strength = get_side_strength(defender_armies);
	
	var diff = abs(attacker_strength - defender_strength);
	
	if (attacker_strength < defender_strength):
		for a_id: int in attacker_armies:
			GameInstance.game_instance.get_army_by_id(a_id).lose_unit(50);
	if (attacker_strength > defender_strength):
		for a_id: int in defender_armies:
			GameInstance.game_instance.get_army_by_id(a_id).lose_unit(50);
	if (attacker_strength == defender_strength):
		for a_id: int in attacker_armies:
			GameInstance.game_instance.get_army_by_id(a_id).lose_unit(50);
		for a_id: int in defender_armies:
			GameInstance.game_instance.get_army_by_id(a_id).lose_unit(50);


	for a_id: int in attacker_armies:
		var army: Army = GameInstance.game_instance.get_army_by_id(a_id);
		
		if (army.get_unit_count() <= 0):
			army.defeated = true;

	for a_id: int in defender_armies:
		var army: Army = GameInstance.game_instance.get_army_by_id(a_id);
		
		if (army.get_unit_count() <= 0):
			army.defeated = true;

func get_side_strength(side: Array[int]) -> float:
	var output: float = 0;
	var max: int = 0;

	for i: int in side:
		var army: Army = GameInstance.game_instance.get_army_by_id(i);
		var nation: Nation = GameInstance.game_instance.get_nations()[army.nation_owner_id];

		output += army.get_unit_count();
		max += 1;
		if (max >= combat_width):
			break;
	return (output);
	
		
func stop():
	var index: int;
	
	index = GameInstance.game_instance.combats.find(self);
	if (index != -1):
		GameInstance.game_instance.combats.remove_at(index);

func get_province_id() -> int:
	var output: int = -1;
	
	if (not defender_armies.is_empty()):
		output = GameInstance.game_instance.get_army_by_id(defender_armies[0]).province_id;
	return (output);
