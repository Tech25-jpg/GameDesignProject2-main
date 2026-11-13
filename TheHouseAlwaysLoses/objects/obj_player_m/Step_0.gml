if (currently_talking == noone) {
	var _h_input = keyboard_check(vk_right) - keyboard_check(vk_left);
	var _v_input = keyboard_check(vk_down) - keyboard_check(vk_up);
	var _spd = move_speed;

	if (_h_input != 0 || _v_input != 0) {
		if (_h_input > 0)      { facing = 0; sprite_index = spr_male_player_right; }
		else if (_h_input < 0) { facing = 2; sprite_index = spr_male_player_left; }
		else if (_v_input > 0) { facing = 1; sprite_index = spr_male_player_down; }
		else                   { facing = 3; sprite_index = spr_male_player_up; }
		image_speed = 1;
	}
	else {
		image_index = 0;
		image_speed = 0;
	}

	var _tilemap = layer_tilemap_get_id("Collisions");
	var _half = 4;

	if (_tilemap == -1) {
		show_debug_message("Collisions layer not found!");
	}
	else {
		if (_h_input != 0) {
			var _new_x = x + (_h_input * _spd);
			var _edge_x = _new_x + (_h_input * _half);
			if (tilemap_get_at_pixel(_tilemap, _edge_x, y - _half) == 0 &&
			    tilemap_get_at_pixel(_tilemap, _edge_x, y + _half) == 0 &&
				!place_meeting(_new_x, y, obj_solid_parent)) {
				x = _new_x;
			}
		}

		if (_v_input != 0) {
			var _new_y = y + (_v_input * _spd);
			var _edge_y = _new_y + (_v_input * _half);
			if (tilemap_get_at_pixel(_tilemap, x - _half, _edge_y) == 0 &&
			    tilemap_get_at_pixel(_tilemap, x + _half, _edge_y) == 0 &&
				!place_meeting(x, _new_y, obj_solid_parent)) {
				y = _new_y;
			}
		}
	}
}

if (currently_talking != noone && !choosing && current_text_line_number == choice_line && current_text_index >= string_length(current_text)) {
	choosing = true;
	choice_index = 0;
}

// NPC Interaction
if (choosing) {
	if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) ||  keyboard_check_pressed(vk_up) ||  keyboard_check_pressed(vk_down)) {
		choice_index = 1 - choice_index;
	}
	
	if (keyboard_check_pressed(ord("Z"))) {
		var _npc = currently_talking;
		choosing = false;
		choice_line = -1;
		
		dialogue = (choice_index == 0) ? _npc.yes_text : _npc.no_text;
		start_battle = (choice_index == 0);
		current_text_line_number = 0;
		current_text = dialogue[0];
		current_text_index = 0;
	}
}
else if (keyboard_check_pressed(ord("Z"))) {
	if (currently_talking == noone) {
		var _angles = [0, 270, 180, 90];
		var _check_distance = 16;
		var _check_x = x + lengthdir_x(_check_distance, _angles[facing]);
		var _check_y = y + lengthdir_y(_check_distance, _angles[facing]);

		var _npc = instance_place(_check_x, _check_y, obj_interactable_parent);

		if (_npc != noone) {
			currently_talking = _npc;
			dialogue = _npc.text;
			choice_line = _npc.choice_line;
			current_text_line_number = 0;
			current_text_index = 0;
			current_text = dialogue[0];

			with (_npc) {
				if (turns_to_face) {
				var _dir = point_direction(x, y, other.x, other.y);
				var _frames = [3, 0, 1, 2];

				if (_dir >= 45 && _dir < 135)       { facing = 3; } 
				else if (_dir >= 135 && _dir < 225) { facing = 2; } 
				else if (_dir >= 225 && _dir < 315) { facing = 1; }
				else                                { facing = 0; }
				
				image_speed = 0;
				image_index = _frames[facing];
			}
		}
	}
}
	else {
		if (current_text_index < string_length(current_text)) {
			current_text_index = string_length(current_text);
		}
		else if (current_text_line_number < array_length(dialogue) - 1) {
			current_text_line_number++;
			current_text = dialogue[current_text_line_number];
			current_text_index = 0;
		}
		else {
			currently_talking = noone;
			current_text = "";
			current_text_index = 0;
			
			if (start_battle) {
				start_battle = false;
			}
		}
	}
}

if (currently_talking != noone) {
	if (current_text_index < string_length(current_text)) {
		current_text_index += 0.5;
	}
}