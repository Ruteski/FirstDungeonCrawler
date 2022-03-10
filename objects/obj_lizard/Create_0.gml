estado = noone;
tempo_estado = room_speed * 10;
timer_estado = 0;

// estado parado
// estado passeando
// estado persegue player



//metodo de mudança de estado
muda_estado = function(_estado) {
	//diminuindo o tempo do estado SE o tempo é maior que 0
	tempo_estado--;
	
	//timer do estado é aleatorio
	timer_estado = irandom(tempo_estado);
	
	//quando tempo acabar, muda de estado
	if (timer_estado == tempo_estado || tempo_estado <= 0) {
		//mudo de estado
		estado = _estado;
		tempo_estado = room_speed * 10;
	}	
}

//metodo parado
estado_parado = function() {
	image_blend = c_white;
	muda_estado(estado_passeando);
}

// metodo passeando
estado_passeando = function() {
	image_blend = c_red;
	muda_estado(estado_parado);
}

// definindo o estado inicial do inimigo
estado = estado_parado;