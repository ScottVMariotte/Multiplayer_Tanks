/// @description 
speed = SPEED
alarm[0] = room_speed * DURATION

if(instance_exists(obj_player_tank)){
	audio_falloff_set_model(audio_falloff_exponent_distance)
	audio_play_sound_at(laserRetro_001, -1*(x - obj_player_tank.x),y - obj_player_tank.y,depth, 50, 200, .5, false, 1)
}
