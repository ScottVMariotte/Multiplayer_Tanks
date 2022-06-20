/// @description Insert description here
// You can write your code in this editor
draw_self()
var _x = x + sprite_width/2 - string_length(Text) * 6
var _y = y + sprite_height/2 - 12

draw_set_color(c_white)
if(hover && mouse_check_button(mb_left)){ draw_set_color(c_green) }
draw_text(_x, _y, Text)

