/// @description Insert description here
// You can write your code in this editor
_width = 2560/2
_height = 1440/2

_follow = noone
_CAMERA = camera_create()

_cam_scale = .3

var vm = matrix_build_lookat(x,y,-10,x,y,0,0,1,0)
var pm = matrix_build_projection_ortho(_width*_cam_scale, _height*_cam_scale, 1, 10000)
camera_set_view_mat(_CAMERA, vm)
camera_set_proj_mat(_CAMERA, pm)

view_camera[0] = _CAMERA

function follow(ID){
	_follow = ID
}

