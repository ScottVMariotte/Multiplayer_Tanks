/// @description 
var TYPE = async_load[? "type"]
var SOCKET = async_load[? "socket"]

switch(TYPE){
	case network_type_connect:
		//Generate and send the client an ID
		var ID = unique_ID()
		
		for(var i = 0; i < num_connections; i ++){
			var client = list_clientID[| i]
			client_dump(client, SOCKET)
		}
		 
		add_connection(SOCKET, ID)
		
		buff_clear(T_CLIENT_ID)
		buffer_write(server_buffer, B_CLIENT_ID, ID)
		buffer_write(server_buffer, B_CLIENT_ID, ID)
		network_send_packet(SOCKET, server_buffer, buffer_tell(server_buffer))
		
	break
	case network_type_disconnect:
		var CLIENT_ID = map_socket_clientID[? SOCKET]
		
		buff_clear(T_DISCONNECT)
		buffer_write(server_buffer, B_CLIENT_ID, CLIENT_ID)
		delete_connection(SOCKET, CLIENT_ID)
		pass()
		
	break
	case network_type_data:
		var PACKET = async_load[? "buffer"]
		var CLIENT_ID = buffer_read(PACKET, B_CLIENT_ID)
		var PACKET_ID = buffer_read(PACKET, B_PACK_ID)
		
		SOCKET = map_clientID_socket[? CLIENT_ID]
		
		switch(PACKET_ID){
			
			case T_OBJECT_CREATE:
				var obj_server_index = buffer_read(PACKET, B_OBJECT_INDEX)
				var obj_shallow_index = buffer_read(PACKET, B_OBJECT_INDEX)

				var object_id = buffer_read(PACKET, B_OBJECT_ID)
				var inst = scr_create_entity(-50,-50,obj_server_index, CLIENT_ID, object_id)
				add_instance(inst)
				
				buff_clear(T_OBJECT_CREATE)
				buffer_write(server_buffer, B_OBJECT_INDEX, obj_shallow_index)
				buffer_write(server_buffer, B_CLIENT_ID, CLIENT_ID)
				buffer_write(server_buffer, B_OBJECT_ID, object_id)
				pass_exclude(SOCKET)

			break
			
			case T_PROJECTILE_CREATE:
				
				var index = buffer_read(PACKET, B_OBJECT_INDEX)
				var X = buffer_read(PACKET, B_POS)
				var Y = buffer_read(PACKET, B_POS)
				var angle = buffer_read(PACKET, B_ANG)
				
				scr_create_projectile(index, X, Y, angle, CLIENT_ID)
				
				buff_clear(T_PROJECTILE_CREATE)
				buffer_write(server_buffer, B_CLIENT_ID, CLIENT_ID)
				buffer_write(server_buffer, B_OBJECT_INDEX, index)
				buffer_write(server_buffer, B_POS, X)
				buffer_write(server_buffer, B_POS, Y)
				buffer_write(server_buffer, B_ANG, angle)
				pass_exclude(SOCKET)
				
				//pass what was read in to all but the sender
				
			break
			
			case T_MOVE:
				var OBJECT_ID = buffer_read(PACKET, B_OBJECT_ID)
				
				var inst = get_instace(CLIENT_ID, OBJECT_ID)
				if(inst == undefined){break}
				
				var X = buffer_read(PACKET, B_POS)
				var Y = buffer_read(PACKET, B_POS)
				var ang = buffer_read(PACKET, B_ANG)
				var imgNum = buffer_read(PACKET, B_IMG_NUM)
				inst.update_pos_state(X,Y,ang,imgNum)
				
				buff_clear(T_MOVE)
				buffer_write(server_buffer, B_CLIENT_ID, CLIENT_ID)
				buffer_write(server_buffer, B_OBJECT_ID, OBJECT_ID)
				buffer_write(server_buffer, B_POS, X)
				buffer_write(server_buffer, B_POS, Y)
				buffer_write(server_buffer, B_ANG, ang)
				buffer_write(server_buffer, B_IMG_NUM, imgNum)
				pass_exclude(SOCKET)

			break
		}
	
	break
}
