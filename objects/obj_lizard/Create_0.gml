// estado parado
// estado passeando
// estado persegue player

estado = noone;
tempo_estado = room_speed * 10;
timer_estado = 0;

destino_x = x;
destino_y = y;

vel = 1;


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

//metodo parado
estado_parado = function() {
	sprite_index = spr_lizard_idle;
	image_blend = c_white;
	muda_estado([estado_passeando, estado_parado]);
}

// metodo passeando/andar
estado_passeando = function() {
	//definindo a sprite
	sprite_index = spr_lizard_run;
	
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
	
	//movendo para o destino
	x += lengthdir_x(vel, _dir);
	y += lengthdir_y(vel, _dir);
	
	image_blend = c_red;
	muda_estado([estado_parado, estado_passeando]);
}

// definindo o estado inicial do inimigo
estado = estado_parado;