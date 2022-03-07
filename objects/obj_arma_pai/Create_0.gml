//deixando o cajado menor
image_xscale = 0.5;
image_yscale = 0.5;

atirar = false;

//delay para atirar
delay_tiro = 0;

pai = noone;

//metodo para atirar
atirando = function() {
	delay_tiro--;	
	
	if (atirar) {
		//cria o tiro dentro do intervalo de tiro
		if (delay_tiro <= 0) {
			//reseta delay tiro
			delay_tiro = espera_tiro * room_speed;
			
			//achando posicao para criar o tiro
			var _x = lengthdir_x(sprite_width, image_angle);
			var _y = lengthdir_y(sprite_width, image_angle);
			
			//atirando
			var _tiro = instance_create_layer(x + _x , y + _y, layer, tiro);
			
			//velocidade do tiro
			_tiro.speed = velocidade;
			
			//definindo direcao do tiro
			_tiro.direction = image_angle;
			
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

quica_parede = function() {
	//batendo na parede e voltando
	//check se estou batendo na horizontal
	if (place_meeting(x + hspeed, y, obj_block)) 
		hspeed *= -1;
		
	//check se estou batendo na vertical
	if (place_meeting(x, vspeed + y, obj_block))
		vspeed *= -1;
}