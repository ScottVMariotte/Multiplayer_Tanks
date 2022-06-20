/// @description 
shader_set(sdr_player)
var u = shader_get_uniform(sdr_player, "u_v_rgb")

var tmp_seed = random_get_seed()
random_set_seed(CLIENT_ID)
shader_set_uniform_f(u, random(1), random(1), random(1))
draw_self()
random_set_seed(current_second)

shader_reset()
