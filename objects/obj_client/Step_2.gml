/// @description 

var collisions = ds_list_create()
with(obj_projectile){
	ds_list_clear(collisions)
	collision_point_list(x,y,obj_entity,false,true,collisions,false)
	for(var i = 0; i < ds_list_size(collisions) && penetration > 0; i ++){
		var inst = collisions[| i]
		if(COLLISION_GROUP != inst.COLLISION_GROUP){ 
			penetration --
		}
	}
	if(penetration <= 0){
		instance_destroy()
	}
}
