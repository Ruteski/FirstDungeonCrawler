//deixando o cajado menor
image_xscale = 0.5;
image_yscale = 0.5;

atirar = true;

//delay para atirar
delay_tiro = 0;

//metodo para atirar
atirando = function() {
			
	//olhando para a direlção do mouse
	image_angle = point_direction(x, y, mouse_x, mouse_y);	
	
	if (atirar) {
		//cria o tiro dentro do intervalo de tiro
		delay_tiro--;
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
		}
	}
}