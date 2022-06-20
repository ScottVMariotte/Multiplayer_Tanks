/// @description Insert description here
// You can write your code in this editor

function vec2(X, Y) constructor {
	x = X
	y = Y
	
	function add(v){
		x += v.X
		y += v.Y
	}
	
	function mult(v){
		x *= v.X
		y *= v.Y
	}
	
}

function arsenal() constructor{
	SPRITE = undefined
	PROJECTILES = []
}

function tank() constructor{
	NAME = undefined
	SPRITE = undefined
	ARSENAL = undefined
}

//TANKS
global.TANK_BRAWLER = new tank()
global.TANK_BRAWLER.NAME = "Brawler"
global.TANK_BRAWLER.SPRITE = spr_tank_brawler
global.TANK_BRAWLER.ARSENAL = new arsenal()
global.TANK_BRAWLER.ARSENAL.SPRITE = spr_weapon_brawler_strip2
global.TANK_BRAWLER.ARSENAL.PROJECTILES = [obj_projectile,obj_projectile]


//Networking
global.REMOTE_IP = "scottjmariotte.ddns.net"

#macro B_PACK_ID buffer_u8
#macro B_CLIENT_ID buffer_u8
#macro B_OBJECT_ID buffer_u16
#macro B_OBJECT_INDEX buffer_u32

#macro B_STRING buffer_string
#macro B_IMG_NUM buffer_u8
#macro B_ANG buffer_f16
#macro B_POS buffer_f32
#macro B_DAMAGE buffer_u8



#macro T_CLIENT_ID 0 // Need to pass other user information as whell
#macro T_OBJECT_ID 1
#macro T_DISCONNECT 3
#macro T_OBJECT_CREATE 4
#macro T_CLIENT_DUMP 5
#macro T_PROJECTILE_CREATE 6
#macro T_DAMAGE 7

#macro T_CHAT 8
#macro T_MOVE 9
#macro T_DEAD 10
