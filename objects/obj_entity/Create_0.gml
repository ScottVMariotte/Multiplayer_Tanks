/// @description 

//Set by server
CLIENT_ID = undefined

//Set by client
OBJECT_ID = undefined
COLLISION_GROUP = undefined

//set_collision_group()
current_health = MAX_HEALTH

function damage(dmg){
	current_health -= dmg
	if(current_health <= 0){
		instance_destroy()
	}
}
