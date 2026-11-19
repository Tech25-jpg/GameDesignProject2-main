y = ystart + sin(current_time * 0.003) * 4;

if  (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space))	{
		global.save_data = game_data_new();
		audio_stop_all();
		audio_play_sound(snd_pokelullaby, 1, true);
	room_goto(rm_intro);
}