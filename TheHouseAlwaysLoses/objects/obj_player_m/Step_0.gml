// All code relating to input
var _move_right = keyboard_check(vk_right);
var _move_left = keyboard_check(vk_left);
var _move_up = keyboard_check(vk_up);
var _move_down = keyboard_check(vk_down);

var _h_input = _move_right - _move_left;
var _v_input = _move_down - _move_up;

if (_h_input != 0 || _v_input != 0) {
	if (_h_input > 0) {
		facing = 0;
		sprite_index = spr_male_player_right;
	}
	else if (_h_input < 0) {
		facing = 2;
		sprite_index = spr_male_player_left;
	}
	if (_h_input > 0) {
		facing = 1;
		sprite_index = spr_male_player_up;
	}
	else if (_h_input < 0) {
		facing = 3;
		sprite_index = spr_male_player_down;
	}
	
	image_speed = 1;
}
else {
	image_index = 0;
	image_speed = 0;
}
