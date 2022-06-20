/// @description Insert description here
// You can write your code in this editor
MESSAGE_COUNT = 0

list_msgs = ds_list_create()
list_times = ds_list_create()

X_OFF = 15
Y_OFF = 15

function add_msg(text){
	ds_list_add(list_msgs, text)
	ds_list_add(list_times, room_speed)
	MESSAGE_COUNT ++ 
}
