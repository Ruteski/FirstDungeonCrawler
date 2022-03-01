/// @description Insert description here
// You can write your code in this editor


var up, down, left, right, fire;

up = keyboard_check(ord("W"));
left = keyboard_check(ord("A"));
down = keyboard_check(ord("S"));
right = keyboard_check(ord("D"));
fire = mouse_check_button_pressed(mb_left);

//se apertar "A" left = 1
//se apertar "D" right = 1
//velh = (right - left) * max_vel;
//x += velh;  feito a movimentacao no EndStep

//velv = (down - up) * max_vel;
//y += velv;  feito a movimentacao no EndStep


//ajustar movimento
//checando se o usuario esta apertando algo 
if (up || down || left || right){
	//descobrir para que direção esta se movendo 
	move_dir = point_direction(0,0, (right - left), (down - up));
	
	//ganha velocidade ao se mover
	//vel = lerp(vel, max_vel, 0.1);
	vel = max_vel;
} else {
	//vel = 0;
	vel = lerp(vel, 0, 0.1);
	//simulando uma parada no gelo
	//vel = lerp(vel, 0, 0.02);
}

//criando o tiro
if (fire ) {
	var _tiro = instance_create_layer(x, y, "tiros", obj_tiro);
	_tiro.speed = 10;
	_tiro.direction = point_direction(x,y, mouse_x, mouse_y);
}

//com base na direção aplico a velocidade
velh = lengthdir_x(vel, move_dir);
velv = lengthdir_y(vel, move_dir);