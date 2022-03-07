// Inherit the parent event
event_inherited();

espera = room_speed * .5; // espera 1/2 segundo
vel = 0;
rot = -10; //rotacao

atirado = function() {
	image_angle += rot;
	
	//checa se tenho que esperar
	if (espera > 0) {
		//diminuindo o valor da espera
		espera--;
		
		//checa se há velocidade
		if (speed != 0) {
			vel = speed;
			speed = 0;
		} else {
			speed = vel;
		}
	}
}