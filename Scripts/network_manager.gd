extends Node

const SERVER_PORT: int = 25565;

enum COMMAND_TYPE
{
	BUY_PROVINCE,
	MOVE_TROOP,
}

var default_command: Dictionary = {
	"type": COMMAND_TYPE.BUY_PROVINCE,			# COMMAND TYPE ID
	"source": -1, 								# NATION ID
	"target": -1,								# NATION TARGET
	"context": {},								# ANY EXTRA CONTEXT NEEDED
}

var game_commands: Array[Dictionary] = [];
var remote_players: Array[RemotePlayer] = [];

func _ready() -> void:
	#multiplayer.connect("peer_connected", self, "_on_peer_connected")
	#multiplayer.connect("peer_disconnected", self, "_on_peer_disconnected")
	#multiplayer.connect("connection_failed", self, "_on_connection_failed")
	#multiplayer.connect("server_disconnected", self, "_on_server_disconnected")
	
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	
func host_server():
	var peer = ENetMultiplayerPeer.new();
	peer.create_server(SERVER_PORT);
	multiplayer.multiplayer_peer = peer;
	
func connect_to_server(ip: String):
	var peer = ENetMultiplayerPeer.new();
	peer.create_client(ip, SERVER_PORT);
	multiplayer.multiplayer_peer = peer;

func send_clients_commands(commands: Array[Dictionary]):
	for rp: RemotePlayer in remote_players:
		rpc_id(rp.peer_id, "receive_commands_as_client", commands);

@rpc("any_peer", "call_local")
func receive_command_as_host(command: Dictionary):
	DevConsole.instance.add_line("Received command");
	game_commands.append(command);

@rpc("authority")
func receive_commands_as_client(commands: Array[Dictionary]):
	for c in commands:
		game_commands.append(c);
	DevConsole.instance.add_line("Received commands from server!");

@rpc("any_peer")
func receive_ready_as_host():
	var remote_player: RemotePlayer;
	
	remote_player = get_remote_player_by_id(multiplayer.get_remote_sender_id());
	if (not remote_player):
		DevConsole.instance.add_line("Failed to ready check remote player");
		return;
	remote_player.is_ready = true;
	DevConsole.instance.add_line("Player is ready: " + str(remote_player.peer_id));

func send_ready_to_host():
	if (multiplayer.is_server()):
		return;
	rpc_id(1, "receive_ready_as_host");

func is_every_player_ready() -> bool:
	for rp: RemotePlayer in remote_players:
		if (not rp.is_ready):
			return (false);
	return (true);

func ask_clients_to_tick():
	for rp: RemotePlayer in remote_players:
		rpc_id(rp.peer_id, "receive_tick_request");
	
@rpc("authority")
func receive_tick_request():
	GameInstance.game_instance.tick();

func send_commands_to_clients():
	DevConsole.instance.add_line("Sending commands to clients");
	
func send_command_to_host(command: Dictionary):
	rpc_id(1, "receive_command_as_host", command);

func create_remote_player(id: int):
	var temp: RemotePlayer;
	
	temp = RemotePlayer.new();
	temp.peer_id = id;
	temp.is_ready = false;
	remote_players.append(temp);
	DevConsole.instance.add_line("Successully created remote player " + str(id));

func remove_remote_player(id: int):
	var temp: RemotePlayer;
	var index: int = -1;
	
	temp = get_remote_player_by_id(id);
	if (not temp):
		return;
	for i: int in range(0, len(remote_players)):
		if (remote_players[i] == temp):
			index = i;
	if (index == -1):
		return;
	DevConsole.instance.add_line("Successully removed remote player " + str(remote_players[index].peer_id));
	remote_players.remove_at(index);

func get_remote_player_by_id(id: int) -> RemotePlayer:
	for rp: RemotePlayer in remote_players:
		if (rp.peer_id == id):
			return (rp);
	return (null);

func set_all_player_unready():
	for rp: RemotePlayer in remote_players:
		rp.is_ready = false;

func _on_connected_to_server():
	DevConsole.instance.add_line("test")

func _on_player_connected(id: int):
	DevConsole.instance.add_line("A player joined the lobby");
	if (multiplayer.is_server()):
		create_remote_player(id);

func _on_player_disconnected(id: int):
	DevConsole.instance.add_line("A player left the lobby");
	if (multiplayer.is_server()):
		remove_remote_player(id);

func get_default_command() -> Dictionary:
	return (default_command);
