// @desc Rigid camera view on Player
var _cam_w = 240;
var _cam_h = 160;

var _cam_x = x - (_cam_w / 2);
var _cam_y = y - (_cam_h / 2);

_cam_x = clamp(_cam_x, 0, room_width - _cam_w);
_cam_y = clamp(_cam_y, 0, room_height - _cam_h);

camera_set_view_pos(view_camera[0], round(_cam_x), round(_cam_y));