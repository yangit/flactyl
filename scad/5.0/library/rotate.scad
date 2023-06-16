use <./lib.scad>

// notice how each subsequent cube is rotated relative to the previous one's axis
// that is not easy to get using plain rotate() function
// but it is crucial to make rotation humanely predictable if you are
// rotating on 3 axis and do not want one axis to affect another
// sequenceRotate() and sequenceRotateFn() doing the same thing, one is just more readable and easier to debug.
// while sequenceRotateFn() is more flexible and can be used as a parameter to other functions
cubeSize = [ 20, 20, 20 ];
x = 20;
y = -20;
z = 20;
rotateSequence = [ x, y, z ];

color("white") sequenceRotate(rotateSequence) cube(cubeSize);
echo(sequenceRotateFn(rotateSequence));
color("black") moveRotateTranslate(sequenceRotateFn(rotateSequence)) cube(cubeSize);

xAxis = [ 1, 0, 0 ];
yAxis = [ 0, 1, 0 ];
zAxis = [ 0, 0, 1 ];

color("green") sequenceRotate([ 0, 0, 0 ]) showVector(xAxis * 30);
color("red") sequenceRotate([ x, 0, 0 ]) showVector(yAxis * 30);
color("blue") sequenceRotate([ x, y, 0 ]) showVector(zAxis * 30);

color("green") sequenceRotate([ 0, 0, 0 ]) cube(cubeSize);
color("red") sequenceRotate([ x, 0, 0 ]) cube(cubeSize);
color("blue") sequenceRotate([ x, y, 0 ]) cube(cubeSize);