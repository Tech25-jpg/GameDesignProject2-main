var _cx = room_width / 2;
var _cy = room_height / 2 - 10;

var _pulse = abs(sin(current_time * 0.005));
var _col = make_colour_rgb(255, 200 + (_pulse * 55), 100 + (_pulse * 155));

draw_sprite_ext(spr_temporary_titlecard, 0, _cx, _cy, 1, 1, 0, _col, 1);

if ((current_time div 400) % 2 == 0) {
	draw_set_font(fnt_dialogue);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_yellow);
	
	draw_text(_cx, room_height - 24, "PRESS ENTER TO START");
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}