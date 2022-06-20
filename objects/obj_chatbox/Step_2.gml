/// @description Insert description here
// You can write your code in this editor
for(var i = 0; i < MESSAGE_COUNT; i ++){
	list_times[| i] --
	if(list_times[| i] == 0){
		ds_list_delete(list_times, i)
		ds_list_delete(list_msgs, i)
		MESSAGE_COUNT --
	}
}

if(instance_exists(obj_client)){
	instance_destroy()
	x = obj_camera.x + (obj_camera._width/2 * obj_camera._cam_scale) - (sprite_width*obj_camera._cam_scale)
	y = obj_camera.y + (obj_camera._height/2 * obj_camera._cam_scale) - (sprite_height*obj_camera._cam_scale)
}
