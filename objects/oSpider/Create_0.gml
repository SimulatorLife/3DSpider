spiderColour = c_blue;
armNum = 8;
armSegmentLength1 = 150;
armSegmentLength2 = 130;
armsMoving = 0;
maxArmsMoving = 3;
armTarget = [];
for (var i = 0; i < armNum; i ++)
{
	var a = i / armNum * 4 * pi;
	armPos[i] = [x + 150 * cos(a), y + 150 * sin(a), 0];
	armMoving[i] = -1;
	armSpeed[i] = .1;
	armPrevPos[i] = armPos[i];
	armOvershoot[i] = [0, 0]
}

surf = -1;

dbg_section("Spider", true);
dbg_slider_int(ref_create(self, "armNum"), 1, 50);
dbg_colour(ref_create(self, "spiderColour"));
show_debug_overlay(true);