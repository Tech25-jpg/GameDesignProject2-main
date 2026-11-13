// @desc Claude's assistance was used here. Tried to avoid as much GenAI usage as I could.
if (currently_talking != noone) {
	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();
	
	var _scale = 5;
	var _text_scale = 1;
	var _box_w = sprite_get_width(spr_thal_textbox) * _scale;
	var _box_h = sprite_get_height(spr_thal_textbox) * _scale;

	var _box_x = (_gui_w - _box_w) / 2;
	var _box_y = _gui_h - _box_h - 8;

	draw_sprite_ext(spr_thal_textbox, 0, _box_x, _box_y, _scale, _scale, 0, c_white, 1);

	var _border = 10 * _scale;
	var _shown = string_copy(current_text, 1, floor(current_text_index));

	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text_ext(_box_x + _border, _box_y + _border, _shown, 12, _box_w - (_border * 2));

if (choosing) {
	var _opts = ["Yes", "No"];
	var _opt_w = 100;
	var _opt_h = 28;
	var _px = _box_x +_box_w - _opt_w - 8;
	var _py = _box_y -(_opt_h * 2) - 4;
	
	draw_sprite_stretched(spr_choicebox, 0, _px, _py, _opt_w, _opt_h * 2);
	
	for (var i = 0; i < 2; i++) {
		var _ty = _py + 6 + (i * _opt_h);
		draw_set_color(i == choice_index ? c_yellow : c_white);
		draw_text_transformed(_px + 40, _ty, _opts[i], _text_scale, _text_scale, 0);
		
		if (i == choice_index) {
			draw_sprite_ext(spr_choicebox_arrow, 0, _px + 12, _ty + 4, _text_scale, _text_scale, 0, c_white, 1);
		}
	}
	draw_set_color(c_white);
	}
}