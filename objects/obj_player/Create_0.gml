/// @description Insert description here
// You can write your code in this editor

// iniciando variaveis
velh = 0; //velocidade horizontal
velv = 0; //velcodiadde vertical
max_vel = 3; //velocidade maxima de movimento
vel = 0; //velocidade geral
move_dir = 0; //direção que esta se movimentando
arma = noone;


// mostra data e hora formatada
//show_message(date_datetime_string(date_current_datetime()));


//metodo de controle do cajado
usar_arma = function() {
	if (arma) {
		var _fire = mouse_check_button(mb_left);
		arma.atirar = _fire;
		
		//posicao do mouse
		var _dir = point_direction(x, y, mouse_x, mouse_y);
		
		//encontrando a posicao da arma
		var _x = x + lengthdir_x(sprite_width / 2, _dir);
		var _y = y + lengthdir_y(sprite_height / 2, _dir);
		
		//levando a arma com o player
		arma.x = _x;
		arma.y = _y;
		
		//fazendo a arma apontar para o mouse
		arma.image_angle = _dir;
	}
}

//joga arma atual fora
joga_arma = function() {
	if (arma) {
		var _jogar = keyboard_check_released(ord("G"));
		var _col;
		
		//checa se a arma esta dentro da parede, colidindo com o block
		//rodando o codigo de dentro da arma
		with(arma) {
			_col = place_meeting(x, y, obj_block);
		}
		
		if (_jogar && !_col) {
			arma.speed = 3;
			arma.direction = arma.image_angle;
			arma.atirar = false;
			arma = noone;
		}
	}
}