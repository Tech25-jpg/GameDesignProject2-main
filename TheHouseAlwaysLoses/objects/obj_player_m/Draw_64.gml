// @desc Dialogue box, menus, and patron card.
	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();
	var _gw = _gui_w;
	var _gh = _gui_h;
	var _d = global.save_data;
	
if (currently_talking != noone) {
	
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

if (menu_state == MENU.CARD) {
	if (card_anim > 0) {
	var _sx = min(_gw / sprite_get_width(spr_patron_card), _gh / sprite_get_height(spr_patron_card)) * 0.9;
	var _sy = _sx;
	var _card_w = sprite_get_width(spr_patron_card) * _sx;
	var _card_h = sprite_get_height(spr_patron_card) * _sy;
	
	var _cx = (_gw - _card_w) / 2
	var _cy = lerp(_gh, (_gh - _card_h) / 2, card_anim);
	
	draw_sprite_ext(spr_patron_card, 0, _cx, _cy, _sx, _sy, 0, c_white, 1);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	var _ts = min(_sx, _sy) / 2;
	draw_text_transformed(_cx + 16 * _sx, _cy + 30 * _sy, _d.name, _ts, _ts, 0);
	draw_text_transformed(_cx + 16 * _sx, _cy + 50 * _sy, "$" + string(_d.money), _ts, _ts, 0);
	draw_text_transformed(_cx + 16 * _sx, _cy + 70 * _sy, format_time(_d.play_time), _ts, _ts, 0);
	
	var _chips = [
	spr_casino_chip_black,
	spr_casino_chip_blue,
	spr_casino_chip_green,
	spr_casino_chip_purple,
	spr_casino_chip_red,
	spr_casino_chip_special
	];
	var _chip_scale = _sx * 0.45;
	var _chip_start = 30;
	var _chip_gap = 36;
	var _chip_row_y = 120;
	
	var _n = array_length(_chips);
	var _row_start_x = _cx + _card_w / 2 - ((_n - 1) * _chip_gap * _sx) / 2;
	
	for (var b = 0; b < array_length(_d.casino_chips); b++) {
		var _bx = _cx + (_chip_start + b * _chip_gap) * _sx;
		var _by = _cy  + _chip_row_y * _sy;
		var _earned = _d.casino_chips[b];
		
		var _ox = (sprite_get_width(_chips[b]) / 2 - sprite_get_xoffset(_chips[b])) * _chip_scale;
		var _oy = (sprite_get_height(_chips[b]) / 2 - sprite_get_yoffset(_chips[b])) * _chip_scale;
		
		draw_sprite_ext(_chips[b], 0, _bx, _by, _ts, _ts, 0, _earned ? c_white : c_dkgray, _earned ? 1 : 0.5);
		}
	}
}
	
	if (menu_state == MENU.MAIN) {
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		var _mw = 180;
		var _rows = array_length(menu_items);
		var _mh = 14 + _rows * 28;
		var _mx = _gw - _mw - 8;
		var _my = 8;
		draw_sprite_stretched(spr_choicebox, 0, _mx, _my, _mw, _mh);
		for (var i = 0; i < _rows; i++) {
			var _ty = _my + 10 + i * 28;
			draw_set_color(i == menu_index ? c_yellow : c_white);
			draw_text(_mx + 40, _ty, menu_items[i]);
			if (i == menu_index) draw_sprite(spr_choicebox_arrow, 0, _mx + 14, _ty + 4);
		}
		draw_set_color(c_white);
	}
	
// SAVE/CONFIRMATION
if (menu_state = MENU.SAVE_ASK || menu_state == MENU.SAVE_ASK) {
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_sprite_stretched(spr_choicebox, 0, 8, 8, 200, 110);
	draw_set_color(c_white);
	draw_text(24, 20, "PLAYER " + _d.name);
	draw_text(24, 48, "CHIPS " + string(badge_count()));
	draw_text(24, 76, "TIME " + format_time(_d.play_time));
	
	var _msg;
	if (menu_state == MENU.SAVE_DONE) _msg = _d.name + " saved the game!";
	else if (save_exists)			  _msg = "There is already a save file. Overwrite it?";
	else							  _msg = "Would you like to save the game?";
	draw_sprite_stretched(spr_choicebox, 0, 8, _gh - 72, _gw - 16, 64);
	draw_text_ext(28, _gh - 56, _msg, -1, _gw - 56);
	
	if (menu_state == MENU.SAVE_ASK) {
		var _yw = 110;
		var _yx = _gw - _yw - 8;
		var _yy = _gh - 72 - 76;
		draw_sprite_stretched(spr_choicebox, 0, _yx, _yy, _yw, 70);
		var _yn = ["Yes", "No"];
		for (var i = 0; i < 2; i++) {
			var _ty = _yy + 8 + i * 28;
			draw_set_color(i == save_choice ? c_yellow : c_white);
			draw_text(_yx + 40, _ty, _yn[i]);
			if (i == save_choice) draw_sprite(spr_choicebox_arrow, 0, _yx + 14, _ty + 4);
		}
	}
	draw_set_color(c_white);
}
	