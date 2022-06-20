/// @description Check collisions send data back

buff_clear(T_DAMAGE)
var num_damage = 0
var collisions = ds_list_create()
with(obj_projectile){
	ds_list_clear(collisions)
	collision_point_list(x,y,obj_entity,false,true,collisions,false)
	for(var i = 0; i < ds_list_size(collisions) && penetration > 0; i ++){
		var inst = collisions[| i]
		if(COLLISION_GROUP != inst.COLLISION_GROUP){
			obj_server.write_damage(inst.CLIENT_ID, inst.OBJECT_ID, DAMAGE)
			num_damage ++
			inst.damage(DAMAGE)
			penetration --
		}
	}
	if(penetration <= 0){
		instance_destroy()
	}
}
if(num_damage > 0){
	pass()	
}
