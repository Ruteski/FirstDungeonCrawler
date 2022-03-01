/// @description Insert description here
// You can write your code in this editor


var up, down, left, right;

up = keyboard_check(ord("W"));
left = keyboard_check(ord("A"));
down = keyboard_check(ord("S"));
right = keyboard_check(ord("D"));

//se apertar "A" left = 1
//se apertar "D" right = 1
velh = (right - left) * max_vel;
//x += velh;  feito a movimentacao no EndStep

velv = (down - up) * max_vel;
//y += velv;  feito a movimentacao no EndStep


//ajustar movimento