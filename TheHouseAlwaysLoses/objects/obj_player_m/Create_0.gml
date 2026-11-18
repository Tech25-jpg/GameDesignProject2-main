// All Code in relation to Player //
move_speed = 1;
can_move = true;
facing = 3;

currently_talking = noone;
current_text = "";
current_text_line_number = 0;
current_text_index = 0;

dialogue = [];
choice_line = -1;
choosing = false;
choice_index = 0;
start_battle = false;

interact_target = noone;

menu_state = MENU.CLOSED;
menu_index = 0;
menu_items = ["Patron VIP", "Save", "Title Screen", "Close"];
save_choice = 0;
save_exists = false;

card_anim = 0;
save_done_timer = 0;

if (global.load_pending) {
	x = global.save_data.px
	y = global.save_data.py
	facing = global.save_data.facing;
	global.load_pending = false;
}