//colidindo com o player, atribui arma para ele SE ele nao tem arma
if (other.arma == noone && delay_pega <= 0) {
	other.arma = id;
	pai = other.id;
}