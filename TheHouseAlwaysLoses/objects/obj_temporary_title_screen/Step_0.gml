y = ystart + sin(current_time * 0.003) * 4;

if  (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space)) {
	room_goto(rm_casino_outside);
}