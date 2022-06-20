/// @description 
var PACKET = async_load[? "buffer"]
var PACKET_ID = buffer_read(PACKET, B_PACK_ID)

switch(PACKET_ID){
	case T_CLIENT_ID:
		CLIENT_ID = buffer_read(PACKET, B_CLIENT_ID)
		add_client(CLIENT_ID)
		add_instance(scr_create_entity(irandom(room_width),irandom(room_height), obj_player_tank, CLIENT_ID, unique_ID()))
		
	break
	
	case T_DISCONNECT:
		var client_ID = buffer_read(PACKET, B_CLIENT_ID)
		remove_client(client_ID)
	break
	
	case T_CLIENT_DUMP:
		var C_ID = buffer_read(PACKET, B_CLIENT_ID)
		add_client(C_ID)
		
		while(buffer_tell(PACKET) < buffer_get_size(PACKET)){
			var index = buffer_read(PACKET, B_OBJECT_INDEX)
			var O_ID = buffer_read(PACKET, B_OBJECT_ID)
			add_instance(scr_create_entity(-50,-50,index, C_ID, O_ID))
		}
	break
	
	case T_DAMAGE:
		while(buffer_tell(PACKET) < buffer_get_size(PACKET)){
			var client_ID = buffer_read(PACKET, B_CLIENT_ID)
			var object_ID = buffer_read(PACKET, B_OBJECT_ID)
			var dmg = buffer_read(PACKET, B_DAMAGE)
			var inst = map_clients[? client_ID][? object_ID]
			if(inst != undefined){
				inst.damage(dmg)
			}
		}
	break
	
	case T_OBJECT_CREATE:
		var shallow_index = buffer_read(PACKET, B_OBJECT_INDEX)
		var client_ID = buffer_read(PACKET, B_CLIENT_ID)
		var object_ID = buffer_read(PACKET, B_OBJECT_ID)
		show_debug_message(map_clients[? client_ID])
		if(map_clients[? client_ID] == undefined){
			add_client(client_ID)
		}
		
		var inst = scr_create_entity(-50,-50,shallow_index, client_ID, object_ID)
		add_instance(inst)
		
	break
	
	case T_PROJECTILE_CREATE:
	
		var group = buffer_read(PACKET, B_CLIENT_ID)
		var index = buffer_read(PACKET, B_OBJECT_INDEX)
		var X = buffer_read(PACKET, B_POS)
		var Y = buffer_read(PACKET, B_POS)
		var angle = buffer_read(PACKET, B_ANG)
		
		scr_create_projectile(index, X, Y, angle, group)
		
	break
	
	case T_MOVE:
		var client_ID = buffer_read(PACKET, B_CLIENT_ID)
		var object_ID = buffer_read(PACKET, B_OBJECT_ID)
		var inst = get_instace(client_ID, object_ID)
		if(inst == undefined){break}
		
		var X = buffer_read(PACKET, B_POS)
		var Y = buffer_read(PACKET, B_POS)
		var ang = buffer_read(PACKET, B_ANG)
		var imgNum = buffer_read(PACKET, B_IMG_NUM)
		inst.update_pos_state(X, Y, ang, imgNum)
		
	break
	
}
