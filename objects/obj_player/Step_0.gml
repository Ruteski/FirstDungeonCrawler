var up, down, left, right;

up = keyboard_check(ord("W"));
left = keyboard_check(ord("A"));
down = keyboard_check(ord("S"));
right = keyboard_check(ord("D"));

//se apertar "A" left = 1
//se apertar "D" right = 1
//velh = (right - left) * max_vel;
//x += velh;  feito a movimentacao no EndStep

//velv = (down - up) * max_vel;
//y += velv;  feito a movimentacao no EndStep


//show_debug_message(arma);

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

//com base na direção aplico a velocidade
velh = lengthdir_x(vel, move_dir);
velv = lengthdir_y(vel, move_dir);

