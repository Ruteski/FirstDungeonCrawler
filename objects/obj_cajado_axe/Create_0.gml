/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();


//calculo de angulos para varios tiros iniciando em -45, e o tiro do meio(reto) ser o angulo 0
// 90/(qtd_tiros - 1) -> 90/(5 - 1) = 22,5  || o -1 é pq o valor do meio que é zero não conta ficando
// 2 pra cima de 0 e dois pra baixo de 0

//metodo para atirar
atirando = function() {
	delay_tiro--;	
	
	if (atirar) {
		//cria o tiro dentro do intervalo de tiro
		if (delay_tiro <= 0) {
			//reseta delay tiro
			delay_tiro = espera_tiro * room_speed;
			
			for (var i = 0; i < qtd; i++) {
				
				//achando o valor da direcao
				var _val = 90 / (qtd - 1);
				//var _val = 180 / (qtd - 1);
				
				//direcao do tiro
				var _dir = -45 + (i * _val);
				//var _dir = -90 + (i * _val);
				
				//achando posicao para criar o tiro
				var _x = lengthdir_x(sprite_width, image_angle + _dir);
				var _y = lengthdir_y(sprite_width, image_angle + _dir);
			
				//atirando
				var _tiro = instance_create_layer(x + _x , y + _y, layer, tiro);
			
				//velocidade do tiro
				_tiro.speed = velocidade;
			
				//definindo direcao do tiro com base na imprecisao
				_tiro.direction = image_angle + random_range(-imprecisao, imprecisao) + _dir;
			}
			
			//empurrando o player
			if (pai) {
				//achando o valor de velh e velv com base na direção
				var _velh = lengthdir_x(knockback, image_angle);
				var _velv = lengthdir_y(knockback, image_angle);
				
				pai.velh -= _velh;
				pai.velv -= _velv;
				
			}
		}
	}
}
