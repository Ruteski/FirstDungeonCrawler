/// @description Insert description here
// You can write your code in this editor

// iniciando variaveis
velh = 0; //velocidade horizontal
velv = 0; //velcodiadde vertical
max_vel = 3; //velocidade maxima de movimento
vel = 0; //velocidade geral
move_dir = 0; //direção que esta se movimentando
arma = noone;
dano = false;
vida_max = 3;
vida = vida_max;

//tempo de invencibilidade
// 2 segundo invencivel
tempo_inv = room_speed * 2;


// mostra data e hora formatada
//show_message(date_datetime_string(date_current_datetime()));

xscale = 1;
// metodo de olhar para onde o jogador ta mirando
olha_mouse = function() {
	//checa se o x do mouse do jogador é maior que o meu x
	/**if (mouse_x >= x) {
		//olha pra direita
		xscale = 1;
	} else {
		//olha pra esquerda
		xscale = -1
	}*/
	
	xscale = mouse_x - x != 0 ? sign(mouse_x - x) : 1;
}

efeito_dano = function() {
	static _valor = -0.05;
	
	//se tomou dano, muda a transparencia
	if (!dano) {
		return;
	}
	
	//se sumiu, valor fica positivo, se apareceu, valor fica negativo
	if (image_alpha <= 0) {
		_valor *= -1;
	}
	
	// se tiver totalmente visivel o valor fica positivo
	if (image_alpha > 1) {
		_valor *= -1;
	}
	
	image_alpha += _valor;
}

toma_dano = function() {
	// perco 1 de vida se ainda nao perdi vida
	if (dano) {
		return;
	}
	
	vida--;	
	
	dano = true;
	
	// garante que eu posso tomar dano depois de um tempo
	alarm[0] = tempo_inv;
}


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
			
			//retira atribuicao de pai da arma
			arma.pai = noone;
			
			//delay para poder pegar a arma novamente
			arma.delay_pega = room_speed * 2;
			
			arma = noone;
		}
	}
}