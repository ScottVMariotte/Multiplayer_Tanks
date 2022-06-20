/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

OBJ_SHALLOW = obj_player_tank_shallow
OBJ_SERVER = obj_player_tank_server

camera = instance_create_layer(x,y,global.LAYER_INSTANCE_ID, obj_camera)
camera.follow(id)

