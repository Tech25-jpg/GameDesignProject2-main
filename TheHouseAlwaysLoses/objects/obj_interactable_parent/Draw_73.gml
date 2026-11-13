if (instance_exists(obj_player_m)) {
	var _near = distance_to_object(obj_player_m) < 12;
	var _idle = (obj_player_m.currently_talking == noone);
	
	if (_near && _idle) {
		var _zx = (bbox_left + bbox_right) / 2;
		var _zy = bbox_top - 2 + sin(current_time / 200) * 1.5;
		
		draw_sprite(spr_interaction_z, 0, _zx, _zy);
	}
}