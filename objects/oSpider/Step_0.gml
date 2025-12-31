x = mouse_x;
y = mouse_y;

var armMoveHeight = 50;
var armTriggerDist = 40;

var largestInd = -1;
var largestD = 0;
var currArmNum = armNum;
for (var i = 0; i < currArmNum; i++){
	var p = armPos[i];
	var prev = armPrevPos[i];
	var a = current_time / 3000 + i / currArmNum * 6 * pi;
	armTarget[i] = [x + 150 * cos(a), y + 150 * sin(a), 0];
	var target = armTarget[i];
	if (armMoving[i] < 0)
	{
		
		var d = point_distance(p[0], p[1], target[0], target[1]);
		if (d > armTriggerDist && d > largestD && armsMoving < maxArmsMoving)
		{
			largestD = d;
			largestInd = i;
		}
	}
	else
	{
		armMoving[i] = min(armMoving[i] + armSpeed[i], 1);
		var overshoot = armOvershoot[i];
		p[@ 0] = lerp(prev[0], target[0] + overshoot[0], armMoving[i]);
		p[@ 1] = lerp(prev[1], target[1] + overshoot[1], armMoving[i]);
		p[@ 2] = armMoveHeight * sin(armMoving[i] * pi);

		if (armMoving[i] == 1)
		{
			armMoving[i] = -1;
			armsMoving --;
		}
	}
}
if (largestInd >= 0)
{
	var i = largestInd;
	var p = armPos[i];
	var prev = armPrevPos[i];
	armMoving[i] = 0;
	armSpeed[i] = .1 * largestD / armTriggerDist;
	armsMoving ++;
	var target = armTarget[i];
	array_copy(prev, 0, p, 0, 3);
			
	//Make it overshoot slightly
	var overshoot = armOvershoot[i];
	overshoot[@ 0] = .5 * armTriggerDist * (target[0] - p[0]) / largestD;
	overshoot[@ 1] = .5 * armTriggerDist * (target[1] - p[1]) / largestD;	
}