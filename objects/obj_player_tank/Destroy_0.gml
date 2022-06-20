/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var inst = scr_create_entity(irandom(room_width), irandom(room_height), obj_player_tank, CLIENT_ID, obj_client.unique_ID())
obj_client.add_instance(inst)

