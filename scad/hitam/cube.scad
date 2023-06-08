use <./lib.scad>

module gimbalRotate(vector)
{
    x = vector[0];
    y = vector[1];
    z = vector[2];
    xVector = [ 1, 0, 0 ];
    yVector = [ 0, cos(x), sin(x) ];
    zVector = [ sin(y), -sin(x) * cos(y), cos(x) * cos(y) ];
    rotate(a = z, v = zVector) rotate(a = y, v = yVector) rotate(a = x, v = xVector) children(0);
}

// x = -10;
// y = -10;
// z = 10;
cubeSize = [ 30, 1, 20 ];
gimbalRotate([ -10, -10, 10 ]) cube(size = cubeSize);
// color("green") cube(cubeSize);
// xVector = [ 1, 0, 0 ];
// color("green") showVector(xVector);

// color("red") rotate(a = x, v = [ 1, 0, 0 ]) cube(cubeSize);
// yVector = [ 0, cos(x), sin(x) ];
// color("red") showVector(yVector);

// // zVector = [ sin(y), -sin(x), cos(x) ]; // works for x modifications only (y = 0)
// // zVector = [ sin(y), 0, 0 ]; // works for x modifications only (y = 90)
// // zVector = [ sin(y), sin(x), -cos(x) ]; // works for x modifications only (y = 180)
// // zVector = [ sin(y), 0, 0 ]; // works for x modifications only (y = 270)

// color("blue") showVector(vector = zVector);
// zVector = [ sin(y), -sin(x) * cos(y), cos(x) * cos(y) ]; // works for x and y
// color("blue") showVector(zVector);
// color("blue") rotate(a = y, v = yVector) rotate(a = x, v = [ 1, 0, 0 ]) cube(cubeSize);

// color("orange") rotate(a = z, v = zVector) rotate(a = y, v = yVector) rotate(a = x, v = [ 1, 0, 0 ]) cube(cubeSize);