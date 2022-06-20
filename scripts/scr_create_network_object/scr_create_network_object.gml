// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_create_network_object(X,Y, ID, objIndex){
	var inst = instance_create_layer(X,Y, global.LAYER_INSTANCE_ID, objIndex)
	inst.OBJECT_ID = ID
	return inst
}