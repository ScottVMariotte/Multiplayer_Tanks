/// @description 
image_speed = 0
gun_arsenal = undefined
projectile = undefined
selected_gun = 0

function shoot(){
	
}

function set_arsenal(arsenal, gun){
	gun_arsenal = arsenal
	selected_gun = gun
	projectile = gun_arsenal.PROJECTILES[selected_gun]
	sprite_index = gun_arsenal.SPRITE
	image_index = selected_gun
}
