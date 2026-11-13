/// @desc - battle controller
enum states {
	battlestart,
	playerchoose,
	playerdealdamage,
	enemyattack,
	enemyend,
	battleend
}

state = state.battlestart;

alarm[0] = 60;

enemy_has_attacked = false;
current_battle_message = "";