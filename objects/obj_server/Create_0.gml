PORT = 7630
TYPE = network_socket_tcp
MAX_PLAYERS = 10

SERVER = network_create_server(TYPE, PORT, MAX_PLAYERS)

if(SERVER < 0){ 
	instance_destroy(); 
	exit
}
room_goto(room_host)

server_buffer = buffer_create(1024, buffer_fixed, 1)

//Connection managment
num_connections = 0
list_clientID = ds_list_create()
map_clientID_socket = ds_map_create()
map_socket_clientID = ds_map_create()

map_clients = ds_map_create()
map_list_clients = ds_map_create()

function add_connection(SOCKET, ID){
	scr_msg("Client " + string(ID) + " Connected")
	ds_list_add(list_clientID, ID)
	ds_map_add(map_socket_clientID, SOCKET, ID)
	ds_map_add(map_clientID_socket, ID, SOCKET)
	ds_map_add(map_clients, ID, ds_map_create())
	ds_map_add(map_list_clients, ID, ds_list_create())
	num_connections ++
}

function delete_connection(SOCKET, ID){
	scr_msg("Client " + string(ID) + " disconnected ")
	ds_list_delete(list_clientID, ds_list_find_index(list_clientID, ID))
	ds_map_delete(map_socket_clientID, SOCKET)
	ds_map_delete(map_clientID_socket, ID)
	
	var insts = map_clients[? ID]//Map of all instances with this client
	var ids = map_list_clients[? ID]//maps for all instances in the map
	for(var i = 0; i < ds_list_size(ids); i ++){//Destroy all instances owned by client
		instance_destroy(insts[? ids[| i]])
	}
	
	ds_map_destroy(map_clients[? ID])
	ds_list_destroy(map_list_clients[? ID])
	num_connections --
}

//Object managment
map_clients = ds_map_create()//Object IDs per client to instances
map_list_clients = ds_map_create()

function unique_ID(){
	var ID = irandom(255)
	while(map_clientID_socket[? ID] != undefined){
		ID = irandom(255)
	}
	return ID
}

#region //instance managment

function add_instance(inst){
	var client_id = inst.CLIENT_ID
	var object_id = inst.OBJECT_ID
	
	ds_map_add(map_clients[? client_id], object_id, inst)
	ds_list_add(map_list_clients[? client_id], object_id)
}

function remove_instance(CLIENT_ID, OBJECT_ID){
	instance_destroy(map_clients[? CLIENT_ID][? OBJECT_ID])
	ds_map_delete(map_clients[? CLIENT_ID], OBJECT_ID)
	ds_list_delete(map_list_clients[? CLIENT_ID], ds_list_find_index(map_list_clients[? CLIENT_ID], OBJECT_ID))
}

function client_dump(client, socket){
	buff_clear(T_CLIENT_DUMP)
	buffer_write(server_buffer, B_CLIENT_ID, client)
	
	show_debug_message(buffer_tell(server_buffer))
	
	var insts = map_clients[? client]
	var insts_ids = map_list_clients[? client]
	for(var i = 0; i < ds_list_size(insts_ids); i ++){
		var inst = insts[? insts_ids[|i]]
		buffer_write(server_buffer, B_OBJECT_INDEX, inst.OBJ_SHALLOW)
		buffer_write(server_buffer, B_OBJECT_ID, inst.OBJECT_ID)
	}

	show_debug_message(buffer_tell(server_buffer))

	network_send_packet(socket, server_buffer, buffer_tell(server_buffer))
}

function get_instace(client_ID, object_ID){
	return map_clients[? client_ID][? object_ID]
}

#endregion 

#region //buffer managment

function buff_clear(TYPE){
	buffer_seek(server_buffer, buffer_seek_start, 0)
	buffer_write(server_buffer, B_PACK_ID, TYPE)
}

function pass_exclude(SOCKET_EXCLUDE){
	for(var i = 0; i < num_connections; i ++){
		var ID = list_clientID[| i]
		var SOCKET = map_clientID_socket[? ID]
		if(SOCKET == SOCKET_EXCLUDE){continue}
		network_send_packet(SOCKET, server_buffer, buffer_tell(server_buffer))
	}
}

function write_damage(CLIENT_ID, OBJECT_ID, DAMAGE){
	buffer_write(server_buffer, B_CLIENT_ID, CLIENT_ID)
	buffer_write(server_buffer, B_OBJECT_ID, OBJECT_ID)
	buffer_write(server_buffer, B_DAMAGE, DAMAGE)
}

function pass(){
	for(var i = 0; i < num_connections; i ++){
		var ID = list_clientID[| i]
		var SOCKET = map_clientID_socket[? ID]
		network_send_packet(SOCKET, server_buffer, buffer_tell(server_buffer))
	}
}

#endregion
