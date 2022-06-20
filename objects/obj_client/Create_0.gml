/// @description 
network_set_config(network_config_connect_timeout, 4000)

PORT = 7630
TYPE = network_socket_tcp

IP = get_string("Remote IP : ","scottjmariotte.ddns.net")

CLIENT = network_create_socket(TYPE)
if(network_connect(CLIENT, IP, PORT) < 0){ 
	scr_msg("Failed to connect to server")
	instance_destroy(); 
	exit
}

client_buffer = buffer_create(1024, buffer_fixed, 1)
CLIENT_ID = -1

map_clients = ds_map_create()
map_list_clients = ds_map_create()

room_goto(room_play)

function add_client(CLIENT_ID){
	ds_map_add(map_clients, CLIENT_ID, ds_map_create())
	ds_map_add(map_list_clients, CLIENT_ID, ds_list_create())
}


function remove_client(CLIENT_ID){
	var insts = map_clients[? CLIENT_ID]//Map of all instances with this client
	var ids = map_list_clients[? CLIENT_ID]//Kets for all instances in the map
	for(var i = 0; i < ds_list_size(ids); i ++){//Destroy all instances owned by client
		instance_destroy(insts[? ids[| i]])
	}
	
	ds_map_delete(map_clients, CLIENT_ID)
	ds_map_delete(map_list_clients, CLIENT_ID)
}

function add_instance(inst){
	var client_id = inst.CLIENT_ID
	var object_id = inst.OBJECT_ID
	ds_map_add(map_clients[? client_id], object_id, inst)
	ds_list_add(map_list_clients[? client_id], object_id)
	
	//Send instance to server
	if(client_id == CLIENT_ID){
		buff_clear(T_OBJECT_CREATE)
		buffer_write(client_buffer, B_OBJECT_INDEX, inst.OBJ_SERVER)
		buffer_write(client_buffer, B_OBJECT_INDEX, inst.OBJ_SHALLOW)
		buffer_write(client_buffer, B_OBJECT_ID, object_id)
		network_send_packet(CLIENT, client_buffer, buffer_tell(client_buffer))
	}
}

function remove_instance(CLIENT_ID, OBJECT_ID){
	instance_destroy(map_clients[? CLIENT_ID][? OBJECT_ID])
	ds_map_delete(map_clients[? CLIENT_ID], OBJECT_ID)
	ds_list_delete(map_list_clients[? CLIENT_ID], ds_list_find_index(map_list_clients[? CLIENT_ID], OBJECT_ID))
}

function get_instace(client_ID, object_ID){
	var client_map = map_clients[? client_ID]
	if(client_map == undefined){
		return undefined
	}
	return client_map[? object_ID]
}

#region //Network send

function unique_ID(){
	var ID = irandom(255)
	var client_map = map_clients[? CLIENT_ID]
	while(client_map[? ID] != undefined){
		ID = irandom(255)
	}
	return ID
}

function buff_clear(TYPE){
	buffer_seek(client_buffer, buffer_seek_start, 0)
	buffer_write(client_buffer, B_CLIENT_ID, CLIENT_ID)
	buffer_write(client_buffer, B_PACK_ID, TYPE)
}

function send_projectile(index, X, Y, angle){
	buff_clear(T_PROJECTILE_CREATE)
	buffer_write(client_buffer, B_OBJECT_INDEX, index)
	buffer_write(client_buffer, B_POS, X)
	buffer_write(client_buffer, B_POS, Y)
	buffer_write(client_buffer, B_ANG, angle)
	network_send_packet(CLIENT, client_buffer, buffer_tell(client_buffer))
}

function send_move(object_ID, x, y, imageAngle, imageNumber){
	buff_clear(T_MOVE)
	buffer_write(client_buffer, B_OBJECT_ID, object_ID)
	buffer_write(client_buffer, B_POS, x)
	buffer_write(client_buffer, B_POS, y)
	buffer_write(client_buffer, B_ANG, imageAngle)
	buffer_write(client_buffer, B_IMG_NUM, imageNumber)
	network_send_packet(CLIENT, client_buffer, buffer_tell(client_buffer))
}

#endregion


