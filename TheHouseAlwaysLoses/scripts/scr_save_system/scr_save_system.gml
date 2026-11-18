//@desc Save System
	enum MENU { CLOSED, MAIN, CARD, SAVE_ASK, SAVE_DONE }
	
	global.save_file = "save.json";
	global.load_pending = false;
	
	function game_data_new() {
		return {
			name: "PLAYER",
			gender: 0, // 0 = boy, 1 = girl
			money: 3000,
			casino_chips: [false, false, false, false, false, false],
			play_time: 0,
			flags: {},
			room_name: "rm_casino_outside",
			px: 0, py: 0, facing: 1
		};
}

global.save_data = game_data_new();

function badge_count() {
	var _n = 0;
	for (var i = 0; i < array_length(global.save_data.casino_chips); i++) {
		if (global.save_data.casino_chips[i]) _n++;
	}
	return _n;
}

function format_time(_secs) {
_secs = floor(_secs)
var _h = _secs div 3600;
var _m = (_secs mod 3600) div 60;
return string(_h) + ":" + (_m < 10 ? "0" : "") + string(_m);
}

function save_game_data() {
	var _d = global.save_data;
	_d.room_name = room_get_name(room);
	_d.px = obj_player_m.x;
	_d.facing = obj_player_m.facing;
	
	var _f = file_text_open_write(global.save_file);
	file_text_write_string(_f, json_stringify(_d));
	file_text_close(_f);
}

function game_read_file() {
	if (!file_exists(global.save_file)) return undefined;
	var _f = file_text_open_read(global.save_file);
	var _json = "";
	while (!file_text_eof(_f)) {
		_json += file_text_read_string(_f);
		file_text_readln(_f);
	}
	file_text_close(_f);
	try { return json_parse(_json); }
	catch (_e) { return undefined; }
}

function game_load() {
	var _d = game_read_file();
	if (_d == undefined) return false;
	var _room = asset_get_index(_d.room_name);
	if (_room == -1) return false;
	
	global.save_data = _d;
	global.load_pending = true;
	room_goto(_room);
	return true;
}