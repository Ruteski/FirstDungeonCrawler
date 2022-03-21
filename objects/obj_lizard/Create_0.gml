// estado parado
// estado passeando
// estado persegue player

//herdando as informações do pai - herança
event_inherited();

//ajustando a vida
vida_max = 3;
vida_atual = vida_max;


estado = noone;
tempo_estado = room_speed * 10;
timer_estado = 0;

destino_x = x;
destino_y = y;

vel = 1;
velh = 0;
velv = 0;

alvo = noone;
alvo_dir = 0;
duracao_ataque = 0.5;
tempo_ataque = duracao_ataque;

//saturacao
sat = 0;

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
	//image_blend = c_fuchsia;
	
	// sprite correta
	sprite = spr_lizard_run;
	
	// checa se o alvo existe
	if (instance_exists(alvo)) {
		// direcao do alvo
		var _dir = point_direction(x, y, alvo.x, alvo.y);
		
		// move na direcao do alvo
		velh = lengthdir_x(vel, _dir);
		velv = lengthdir_y(vel, _dir);
		
		// distancia para o alvo
		var _dist = point_distance(x, y, alvo.x, alvo.y);
		
		// se o alvo estiver mto proximo, prepara o ataque
		if (_dist < largura_visao / 2) {
			estado = estado_prepara_ataque;
		}
		
		// se o alvo esta mto longe, desiste
		if (_dist > largura_visao * 2) {
			alvo = noone;
		}
		
	} else {
		muda_estado([estado_parado, estado_passeando]);
	}

}


// estado de preparacao do ataque(aviso ao jogador que alguma coisa vai acontecer)
estado_prepara_ataque = function() {

	// sat nunca passa de 1
	if (sat < 1) {
		sat += (delta_time / 2000000);
	}
	
	//animacao use a sat
	image_speed = sat;
	
	sprite = spr_lizard_idle;
	
	velh = 0;
	velv = 0;
	
	image_blend = make_color_hsv(255, sat * 255, 255);
	
	// se esperou 2 segundos, entao ataca
	if (sat > 1) {
		estado = estado_ataque;	
		alvo_dir = point_direction(x, y, alvo.x, alvo.y);
		sat = 0;
		image_speed = 1;
	}
	
}

// estado de ataque
estado_ataque = function() {
	// diminuindo tempo de ataque
	tempo_ataque -= delta_time / 1000000;
	
	image_blend = c_white;
	
	//avancando na posicao do jogador, onde ele estava antes de iniciar o ataque
	velh = lengthdir_x(vel * 4, alvo_dir);
	velv = lengthdir_y(vel * 4, alvo_dir);
	
	// saindo do estado de ataque
	if (tempo_ataque <= 0) {
		estado = estado_parado;
		tempo_ataque = duracao_ataque;
	}
}

// definindo o estado inicial do inimigo
estado = estado_parado;