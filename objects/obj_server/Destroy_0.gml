/// @description 
if(SERVER >= 0){
	for(var i = 0; i < num_connections; i ++){
		ds_map_destroy(map_clients[? map_clients[| i]])
	}
	
	ds_list_destroy(list_clientID)
	ds_map_destroy(map_clientID_socket)
	ds_map_destroy(map_socket_clientID)
	ds_map_destroy(map_clients)
}

network_destroy(SERVER)
