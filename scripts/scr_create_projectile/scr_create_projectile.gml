// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_create_projectile(index, X,Y,angle,group){
	var inst = instance_create_layer(X,Y, global.LAYER_INSTANCE_ID, index)
	inst.COLLISION_GROUP = group
	inst.image_angle = angle
	inst.direction = angle
	return inst
}