if(!instance_exists(_follow)){exit}

x = _follow.x
y = _follow.y
var vm = matrix_build_lookat(x,y,-10,x,y,0,0,1,0)
camera_set_view_mat(_CAMERA, vm);

var update = false
if(mouse_wheel_up()){
	_cam_scale += .1
	update = true
}
if(mouse_wheel_down()){
	_cam_scale -= .1
	update = true
}

if(update){
	var pm = matrix_build_projection_ortho(_cam_scale*_width, _cam_scale*_height, 1, 10000);
	camera_set_proj_mat(_CAMERA, pm);
}
