////movendo com base no velh e velv
//x += velh;
//y += velv;

// colisao horizontal
if (place_meeting(x+velh, y, obj_block)) {
	var _velh = sign(velh);	// retorna 1, -1 ou 0
	
	// nao tendo colisao
	while(!place_meeting(x+_velh, y, obj_block)) {
		//move 1 pixel
		x += _velh;
	}
	
	//tendo colisao, acaba a velocidade
	velh = 0;
}

//movimenta
x += velh;

// colisao vertical
if (place_meeting(x, y + velv, obj_block)) {
	var _velv = sign(velv);	// retorna 1, -1 ou 0
	
	// nao tendo colisao
	while(!place_meeting(x, y + _velv, obj_block)) {
		//move 1 pixel
		x += _velv;
	}
	
	//tendo colisao, acaba a velocidade
	velv = 0;
}

//movimenta
y += velv;