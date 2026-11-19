//@desc Email window, colors, window/titlebar - Claude's assistance was used here.
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _w = _gw * 0.9;
var _h = _gh * 0.88;
var _x = (_gw - _w) / 2;
var _y = (_gh - _h) / 2;
var _pad = 16;

var _red   = make_color_rgb(150, 30, 30);
var _paper = make_color_rgb(250, 244, 230);
var _ink   = make_color_rgb(40, 30, 30);
var _line  = make_color_rgb(200, 190, 170);

draw_set_halign(fa_left);
draw_set_valign(fa_top);


draw_set_color(_paper);
draw_rectangle(_x, _y, _x + _w, _y + _h, false);
draw_set_color(_red);
draw_rectangle(_x, _y, _x + _w, _y + 26, false);
draw_set_color(c_white);
draw_text(_x + 8, _y + 5, "Inbox - Royal Time Casino");
draw_set_color(_ink);
draw_rectangle(_x, _y, _x + _w, _y + _h, true);

// Email header
var _subject;
if (state == 0)      _subject = "You're Invited: Complimentary VIP Membership";
else if (state == 4) _subject = "Re: Survey Received";
else                 _subject = "Re: Exclusive VIP Membership Survey";

var _from = (state == 4) ? "Royal Time Casino <vip@royaltime.casino>" : "Royal Time Casino <vip@royaltime.casino>";
var _hy = _y + 36;
draw_set_color(_ink);
draw_text(_x + _pad, _hy,      "From:      " + _from);
draw_text(_x + _pad, _hy + 20, "To:           You");
draw_text(_x + _pad, _hy + 40, "Subject:  " + _subject);
draw_set_color(_line);
draw_line(_x + _pad, _hy + 64, _x + _w - _pad, _hy + 64);

var _bx = _x + _pad;
var _by = _hy + 76;
var _bw = _w - _pad * 2;
draw_set_color(_ink);


if (state == 0) {
	draw_text_ext(_bx, _by, string_copy(body, 1, floor(body_index)), -1, _bw);
	if (body_index >= string_length(body)) {
		draw_set_color(_red);
		draw_text(_bx, _y + _h - 28, "[ Z ]  Open survey");
	}
}

if (state >= 1 && state <= 3) {
	draw_set_color(_red);
	draw_text(_bx, _by, "ROYAL TIME VIP SURVEY");
	draw_set_color(_ink);

	draw_text(_bx, _by + 28, "1. Which best describes you? *");
	var _labels = ["Boy", "Girl"];
	for (var g = 0; g < 2; g++) {
		var _ry = _by + 56 + g * 24;
		var _on = (g == gender_choice);
		draw_circle(_bx + 14, _ry + 8, 7, true);
		if (_on) draw_circle(_bx + 14, _ry + 8, 4, false);
		draw_set_color(_on ? _red : _ink);
		draw_text(_bx + 30, _ry, _labels[g]);
		draw_set_color(_ink);
	}

	if (state >= 2) {
		draw_text(_bx, _by + 118, "2. Enter recipient name for your VIP card: *");
		var _fy = _by + 142;
		draw_set_color(c_white);
		draw_rectangle(_bx, _fy, _bx + 220, _fy + 28, false);
		draw_set_color(_ink);
		draw_rectangle(_bx, _fy, _bx + 220, _fy + 28, true);
		var _cur = (state == 2 && (current_time div 500) mod 2 == 0) ? "|" : "";
		draw_text(_bx + 6, _fy + 6, keyboard_string + _cur);
	}

	if (state == 3) {
		var _btn = ["Submit", "Edit"];
		for (var b = 0; b < 2; b++) {
			var _qx = _bx + b * 110;
			var _qy = _by + 188;
			var _sel = (b == confirm_choice);
			draw_set_color(_sel ? _red : _line);
			draw_roundrect(_qx, _qy, _qx + 96, _qy + 28, false);
			draw_set_color(_sel ? c_white : _ink);
			draw_set_halign(fa_center);
			draw_text(_qx + 48, _qy + 6, _btn[b]);
			draw_set_halign(fa_left);
		}
	}

	draw_set_color(c_gray);
	var _hint = "Up/Down: choose     Z: next";
	if (state == 2) _hint = "Type your name, then press Enter";
	if (state == 3) _hint = "Left/Right: choose     Z: confirm";
	draw_text(_bx, _y + _h - 24, _hint);
}

if (state == 4) {
	var _reply = "Dear " + keyboard_string + ",\n\nThank you for completing the survey. Your VIP card is being printed.\n\nPlease enjoy your stay at Royal Time Casino.\n\n ~The Management";
	draw_text_ext(_bx, _by, _reply, -1, _bw);
}

draw_set_color(c_white);