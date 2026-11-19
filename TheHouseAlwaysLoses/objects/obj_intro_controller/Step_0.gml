if (input_delay > 0) {
	input_delay--;
	exit;
}

var _confirm = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);

switch (state) {
	case 0: // email: text types out, z skips it.
		if (body_index < string_length(body)) body_index += 0.7;
		if (_confirm) {
			if (body_index < string_length(body)) body_index = string_length(body);
			else state = 1;
		}
		break;
		
		case 1: // gender
			if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down)) {
				gender_choice = 1 - gender_choice;
			}
			if (_confirm) {
				global.save_data.gender = gender_choice;
				keyboard_string = "";
				input_delay = 10;
				state = 2;
		}
		break;
		
		case 2: // name
		var _raw = keyboard_string;
		var _clean = "";
		for (var i = 1; i <= string_length(_raw); i++) {
			var _c = string_char_at(_raw, i);
			var _o = ord(_c);
			var _ok = (_o >= 65 && _o <= 90) || (_o >= 97 && _o <= 122) || (_o >= 48 && _o <= 57) || _o == 32;
			if (_ok) _clean += _c;
		}
		_clean = string_copy(_clean, 1, name_max);
		keyboard_string = _clean;
		
		var _has_name = string_length(string_replace_all(_clean, " ", "")) > 0;
		if (keyboard_check_pressed(vk_enter) && _has_name) {
			confirm_choice = 0;
			state = 3;
		}
		break;
		
		case 3: // submit/edit
			if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)) {
				confirm_choice = 1 - confirm_choice;
			}
			if (_confirm) {
				if (confirm_choice == 0) {
					global.save_data.name = keyboard_string;
					done_timer = 150;
					state = 4;
				}
				else {
					input_delay = 5;
					state = 2;
				}
			}
		break;
			
		case 4: // reply email
			done_timer--;
				if (done_timer <= 0 || _confirm) room_goto(rm_casino_outside);
		break;
}