/// @description Insert description here
// You can write your code in this editor
/// @description 

event_inherited()

if(CLIENT >= 0){
	buffer_delete(client_buffer)
}

network_destroy(CLIENT)
