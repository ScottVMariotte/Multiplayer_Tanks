/// @description
if(instance_exists(obj_server)){
	obj_server.remove_instance(CLIENT_ID, OBJECT_ID)
}
if(instance_exists(obj_client)){
	obj_client.remove_instance(CLIENT_ID, OBJECT_ID)
}
