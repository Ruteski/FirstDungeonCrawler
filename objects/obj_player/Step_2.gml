// sistema de colisao e movimentacao horizontal
var _velh = sign(velh); // retorna 1, -1 ou 0


// deixar o velh sempre positivo valor absoluto
repeat(abs(velh)) {
	//checa se o espaço pra onde vou tem alguem, checa se tem colisao
	if (place_meeting(x + _velh, y, obj_block)) {
		velh = 0;
	} else {  //se nao colidiu, move
		x += _velh;
	}
}


// sistema de colisao e movimentacao vertical
var _velv = sign(velv); // retorna 1, -1 ou 0


// deixar o velh sempre positivo valor absoluto
repeat(abs(velv)) {
	//checa se o espaço pra onde vou tem alguem, checa se tem colisao
	if (place_meeting(x, y + _velv, obj_block)) {
		velv = 0;
	} else {  //se nao colidiu, move
		y += _velv;
	}
}

usar_arma();