use <./lib.scad>

// notice how each subsequent cube is rotated relative to the previous one's axis
// that is not easy to get using plain rotate() function

cubeSize = [ 20, 20, 20 ];
rotateVector = [ 20, -20, 20 ];
color("white") gimbalRotate(rotateVector) cube(cubeSize);

xVector = [ 0, 0, 30 ];

color("green") gimbalRotate([ 0, 0, 0 ]) showVector(xVector);
color("red") gimbalRotate([ rotateVector[0], 0, 0 ]) showVector(xVector);
color("blue") gimbalRotate([ rotateVector[0], rotateVector[1], 0 ]) showVector(xVector);

color("green") gimbalRotate([ 0, 0, 0 ]) cube(cubeSize);
color("red") gimbalRotate([ rotateVector[0], 0, 0 ]) cube(cubeSize);
color("blue") gimbalRotate([ rotateVector[0], rotateVector[1], 0 ]) cube(cubeSize);