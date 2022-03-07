atirando();

//diminuindo o delay para poder pegar a arma
if (delay_pega > 0) {
	delay_pega--;
}

//diminuindo velcidade assim que largada a arma
if (speed > 0) {
	quica_parede();
	
	speed *= 0.9;
	
	if (speed <= 0.1)
		speed = 0;
}