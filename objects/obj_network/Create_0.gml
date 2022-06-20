/// @description Insert description here
// You can write your code in this editor
map_clients = ds_map_create()
map_list_clients = ds_map_create()

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
}

function remove_instance(CLIENT_ID, OBJECT_ID){
	instance_destroy(map_clients[? CLIENT_ID][? OBJECT_ID])
	ds_map_delete(map_clients[? CLIENT_ID], OBJECT_ID)
	ds_list_delete(map_list_clients[? CLIENT_ID], ds_list_find_index(map_list_clients[? CLIENT_ID], OBJECT_ID))
}

function get_instace(client_ID, object_ID){
	return map_clients[? client_ID][? object_ID]
}
