/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_gray)
if(instance_exists(obj_camera)){
	draw_rectangle(x,y, x + (sprite_width*obj_camera._cam_scale), y + (sprite_height*obj_camera._cam_scale), false)
}else{
	draw_rectangle(x,y, x + sprite_width, y + sprite_height, false)
}

draw_set_color(c_orange)
var yOff = 0
for(var i = 0; i < MESSAGE_COUNT; i ++){
	draw_text(x + X_OFF,y + Y_OFF + yOff, list_msgs[| i])
	yOff += 15
}
