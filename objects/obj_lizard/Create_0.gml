// estado parado
// estado passeando
// estado persegue player

estado = noone;
tempo_estado = room_speed * 10;
timer_estado = 0;

destino_x = x;
destino_y = y;

vel = 1;
velh = 0;
velv = 0;

alvo = noone;

sprite = sprite_index;
xscale = 1;
yscale = 1;


//metodo de mudança de estado
muda_estado = function(_estado) {
	//diminuindo o tempo do estado SE o tempo é maior que 0
	tempo_estado--;
	
	//timer do estado é aleatorio
	timer_estado = irandom(tempo_estado);
	
	//quando tempo acabar, muda de estado
	if (timer_estado == tempo_estado || tempo_estado <= 0) {
		//checa pra qual estado ir
		estado = _estado[irandom(array_length(_estado) -1 )];
		tempo_estado = room_speed * 10;
	}	
}


//metodo para desenhar sprite
desenha_sprite = function() {
	draw_sprite_ext(sprite, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}

//desenha sombra
desenha_sombra = function() {
	draw_sprite_ext(spr_sombra, 0, x, y, .2, .2,  0, c_white, .25);
}

// campo de visao
///@method campo_visao(largura, altura, escalaX)
campo_visao = function(_largura, _altura, _xscale) {
	var _x1, _x2, _y1, _y2;
	_x1 = x;
	_y1 = y + _altura / 2 - sprite_height / 2;
	_x2 = _x1 + _largura * _xscale;
	_y2 = _y1 - _altura;
	
	// desenhando um quadrado para teste de campo de visao
	//draw_rectangle(_x1, _y1, _x2, _y2, false);
	
	// checa se o jogador esta no campo de visao
	var _alvo = collision_rectangle(_x1, _y1, _x2, _y2, obj_player, 0, 1);
	
	return _alvo;
}

//metodo parado
estado_parado = function() {
	sprite = spr_lizard_idle;
	//image_blend = c_white;
	
	//zerando a velocidade quando estiver parado
	velh = 0;
	velv = 0;
	
	alvo = campo_visao(largura_visao, sprite_height * altura_visao, xscale);
	
	if (alvo) {
		estado = estado_persegue;
	}
	
	muda_estado([estado_passeando, estado_parado]);
}

// metodo passeando/andar
estado_passeando = function() {
	//definindo a sprite
	sprite = spr_lizard_run;
	
	//checando distancia do destino
	var _dist = point_distance(x, y, destino_x, destino_y);
	
	//so define um novo destino se estiver proximo do destino atual
	if (_dist < 100) {
		//escolhe um ponto qualquer na room
		destino_x = random(room_width);
		destino_y = random(room_height);
	}
	
	//achando a direcao para o destino
	var _dir = point_direction(x, y, destino_x, destino_y);
	
	//olhado para a direcao que esta indo
	//evitando que o xscale bugue quando o velh for 0
	if (velh != 0) {
		xscale = sign(velh);
	}
	
	//movendo para o destino
	velh = lengthdir_x(vel, _dir);
	velv = lengthdir_y(vel, _dir);
	
	// olhando para frente
	alvo = campo_visao(largura_visao, sprite_height * altura_visao, xscale);
	
	if (alvo) {
		estado = estado_persegue;
	}
	
	//image_blend = c_red;
	muda_estado([estado_parado, estado_passeando]);
}

// estado perseguindo o jogador
estado_persegue = function() {
	image_blend = c_fuchsia;
	velh = 0;
	velv = 0;
}


// estado de preparacao do ataque(aviso ao jogador que alguma coisa vai acontecer)

// estado de ataque

// definindo o estado inicial do inimigo
estado = estado_parado;