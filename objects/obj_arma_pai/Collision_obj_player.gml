//colidindo com o player, atribui arma para ele SE ele nao tem arma
if (other.arma == noone) {
	other.arma = id;
	pai = other.id;
}