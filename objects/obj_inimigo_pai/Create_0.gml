/// @description Insert description here
// You can write your code in this editor

//variaveis comuns a todos os inimigos
vida_max = 1;
vida_atual = vida_max;


// metodo de levar dano
///@method leva_dano(dano)
//leva_dano = function(_dano = 0) {
leva_dano = function(_dano) {
	//perdendo vida
	if (_dano == undefined) {
		vida_atual -= 1;
	} else {
		vida_atual -= _dano;
	}
}