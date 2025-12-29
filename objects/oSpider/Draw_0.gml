/// @description
draw_clear(c_white);
var spriteWidth = sprite_get_width(sArm);
z = 64 + 20 * sin(current_time / 100);
xDispl = 20 * cos(current_time / 200);

//Draw shadow to a separate surface, then draw that to screen with a reduced alpha
if !surface_exists(surf)
{
	surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
}
surface_set_target(surf);
draw_clear_alpha(c_white, 0);
//Let's give the player a z variable as well, and make it move up and down

for (var i = 0; i < armNum; i ++)
{
	var p = armPos[i];
	var IK = twojointik(x + xDispl, y, z, 0, 0, 1, p[0], p[1], p[2], armSegmentLength1, armSegmentLength2);
	
	//Draw first segment
	var l = 10 + point_distance(x + xDispl, y + z * .25, IK[0], IK[1] + IK[2] * .25);
	var d = point_direction(x + xDispl, y + z * .25, IK[0], IK[1] + IK[2] * .25);
	draw_sprite_ext(sArm, 0, x + xDispl, y + z * .25, l / spriteWidth, 1, d, c_black, 1);
	
	//Draw second segment
	var l = 10 + point_distance(IK[0], IK[1] + IK[2] * .25, IK[3], IK[4] + IK[5] * .25);
	var d = point_direction(IK[0], IK[1] + IK[2] * .25, IK[3], IK[4] + IK[5] * .25);
	draw_sprite_ext(sArm, 0, IK[0], IK[1] + IK[2] * .25, l / spriteWidth, 1, d, c_black, 1);
	
	//Draw claw
	draw_sprite_ext(sClaw, 0, IK[3], IK[4] + IK[5] * .25, sign(IK[3] - x) * .4, .4, 0, c_black, 1);
}
draw_sprite_ext(sSpider, 0, x + xDispl, y + z * .25, 1, 1, 0, c_black, 1);
surface_reset_target();

draw_surface_ext(surf, 0, 0, 1, 1, 0, c_white, .5);

//Let's give the player a z variable as well, and make it move up and down
for (var i = 0; i < armNum; i ++)
{
	var p = armPos[i];
	var IK = twojointik(x + xDispl, y, z, 0, 0, 1, p[0], p[1], p[2], armSegmentLength1, armSegmentLength2);
	
	//Draw first segment
	var l = 10 + point_distance(x + xDispl, y - z * .5, IK[0], IK[1] - IK[2] * .5);
	var d = point_direction(x + xDispl, y - z * .5, IK[0], IK[1] - IK[2] * .5);
	draw_sprite_ext(sArm, 0, x + xDispl, y - z * .5, l / spriteWidth, 1, d, c_white, 1);
	
	//Draw second segment
	var l = 10 + point_distance(IK[0], IK[1] - IK[2] * .5, IK[3], IK[4] - IK[5] * .5);
	var d = point_direction(IK[0], IK[1] - IK[2] * .5, IK[3], IK[4] - IK[5] * .5);
	draw_sprite_ext(sArm, 0, IK[0], IK[1] - IK[2] * .5, l / spriteWidth, 1, d, c_white, 1);
	
	//Draw claw
	draw_sprite_ext(sClaw, 0, IK[3], IK[4] - IK[5] * .5, sign(IK[3] - x) * .4, .4, 0, c_white, 1);
}

draw_sprite(sSpider, 0, x + xDispl, y - z * .5);