/// @description USER_INPUT
var dx = keyboard_check(ord("D")) - keyboard_check(ord("A"))
var dy = keyboard_check(ord("S")) - keyboard_check(ord("W"))

image_angle = point_direction(x,y,mouse_x, mouse_y) - 90

if(mouse_check_button_pressed(mb_left)){
	obj_client.send_projectile(PROJECTILE, x,y,image_angle + 90)
	scr_create_projectile(PROJECTILE, x, y, image_angle + 90, CLIENT_ID)
}

x += dx * SPEED
y += dy * SPEED
