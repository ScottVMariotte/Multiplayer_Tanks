// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_create_entity(X,Y,index, client_id, object_id){
	var inst = instance_create_layer(X,Y,global.LAYER_INSTANCE_ID,index)
	inst.CLIENT_ID = client_id
	inst.OBJECT_ID = object_id
	inst.COLLISION_GROUP = client_id
	return inst
}