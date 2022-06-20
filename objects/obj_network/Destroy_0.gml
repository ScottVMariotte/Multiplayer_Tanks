/// @description Insert description here

for(var i = 0; i < ds_list_size(list_clientID); i ++){
	ds_map_destroy(map_clients[? list_clientID[| i]])
	ds_list_destroy(map_list_clients[? list_clientID[| i]])
}

ds_list_destroy(list_clientID)
ds_map_destroy(map_list_clients)
ds_map_destroy(map_clients)
