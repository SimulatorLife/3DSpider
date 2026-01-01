
/// @param x1
/// @param y1
/// @param z1
/// @param x2dir
/// @param y2dir
/// @param z2dir
/// @param x3
/// @param y3
/// @param z3
/// @param length1
/// @param length2
function twojointik(x1, y1, z1, x2dir, y2dir, z2dir, x3, y3, z3, length1, length2) {
    /*
	    Snidr's Two-joint Inverse Kinematics Algorithm
	    This is a two-joint IK algorithm I've invented myself. It is a very crude way of doing inverse kinematics, but it works well for small adjustments of foot position and the like.

	    The algorithm takes in the positions of two nodes and the lengths of the two bones connecting them, and will return the position of
	    the node inbetween these two positions.
 
	    Returns the 3D position of the middle node (p2) and end node (p3) as an array of the following format:
	        [x2, y2, z2, x3, y3, z3]

	    Script made by TheSnidr 2020
	    www.TheSnidr.com
	*/
	
    // Limit the distance from p1 to p3
	var P1toP3x = x3 - x1;
    var P1toP3y = y3 - y1;
    var P1toP3z = z3 - z1;
    var p1_p3   = sqrt(P1toP3x * P1toP3x + P1toP3y * P1toP3y + P1toP3z * P1toP3z);
    var a       = clamp(p1_p3, abs(length1 - length2), length1 + length2);
    if (a != p1_p3) {
        var d = a / p1_p3;
        P1toP3x *= d;
        P1toP3y *= d;
        P1toP3z *= d;
        x3    = x1 + P1toP3x;
        y3    = y1 + P1toP3y;
        z3    = z1 + P1toP3z;
        p1_p3 = a;
    }

   /* 
    * The idea behind the algorithm is to imagine a sphere placed at P1 with radius of the first bone, and
    * another sphere at P3 with the radius of the second bone. The intersection between these spheres is a
    * circle representing all the possible placements of P2.
    * The first step is to find the middle point of this circle, and the radius of this intersection circle
    */
	
	var p1_p3sqr           = p1_p3 * p1_p3;
    var p2_p3sqr           = length2 * length2;
    var p1_p2sqr           = length1 * length1;
    var intersectionRadius = sqrt(p2_p3sqr - (sqr(p1_p2sqr - p2_p3sqr - p1_p3sqr) / (4 * p1_p3sqr)));
    var l                  = sqrt(p1_p2sqr - (intersectionRadius * intersectionRadius)) / p1_p3;
    if (
        p1_p3sqr < p2_p3sqr - p1_p2sqr
    ) { // If P3 is too close to P1, the "middle" point is on the other side of P1, and l must be negative
        l = -l;
    }
    var middleX = x1 + (P1toP3x * l);
    var middleY = y1 + (P1toP3y * l);
    var middleZ = z1 + (P1toP3z * l);

    // Orthogonalize the P2 direction to the vector from P1 to P3
	var dp = ((x2dir * P1toP3x) + (y2dir * P1toP3y) + (z2dir * P1toP3z)) / p1_p3sqr;
    var mx = x2dir - (P1toP3x * dp);
    var my = y2dir - (P1toP3y * dp);
    var mz = z2dir - (P1toP3z * dp);
    var m  = mx * mx + my * my + mz * mz;
    if (m > 0) {
        m = intersectionRadius / sqrt(m);
    }

    // Displace the middle node to its new position
	var x2 = middleX + (mx * m);
    var y2 = middleY + (my * m);
    var z2 = middleZ + (mz * m);

    return [x2, y2, z2, x3, y3, z3];
}
