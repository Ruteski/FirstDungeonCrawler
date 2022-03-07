atirando();

//diminuindo velcidade assim que largada a arma
if (speed > 0) {
	quica_parede();
	
	speed *= 0.9;
	
	if (speed <= 0.1)
		speed = 0;
}