// @desc - textbox
var _box_x = (display_get_gui_width() - sprite_get_width(spr_thal_textbox)) / 2;
var _box_y = (display_get_gui_height() - sprite_get_height(spr_thal_textbox)) / 20;

draw_sprite(spr_thal_textbox, 0, _box_x, _box_y);

draw_set_font(fnt_dialogue);
draw_set_color(c_white);

var _text_x = _box_x + 16;
var _text_y = _box_y - 12;

draw_text(_text_x, _text_y, current_battle_message);
