// 
switch (state) {
	case states.battlestart:
		current_battle_message = "A challenger steps up to the table!";
		break;
		
	case states.playerchoose:
		current_battle_message = "Choose your card move!";
		break;
		
	case states.playerdealdamage:
		current_battle_message = "You played your card!";
		break;
		
	case states.enemyattack:
		current_battle_message = "The opponent makes their call!";
		
		if (!enemy_has_attacked) {
			enemy_has_attacked = true;
			obj_player.hp -= obj_enemy.myattack;
			
			if (obj_player.hp <= 0) {
				state = states.battleend;
				alarm[3] = 90;
			} else {
				alarm[2] = 60;
			}
		}
		break;
		
	case states.enemyend:
		enemy_has_attacked = false;
		current_battle_message = "End of round.";
		
		state = states.playerchoose;
		break;
		
	case states.battleend:
		if (obj_enemy.hp <= 0) {
			current_battle_message = "You won the battle! Gained EXP!";
			// exp code
		} else {
			current_battle_message = "You ran out of cards.. Looks like the Joker is upon you.";
		}
		if (keyboard_check_pressed(ord("Z"))) {
			room_goto(rm_casino_inside);
		}
		break;
		
	default:
		state = states.battlestart;
		break;
}