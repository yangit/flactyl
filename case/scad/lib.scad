module showVector(vector)
// showVector(vector = [ 10, 10, 10 ]);
{
    start = [ 0, 0, 0 ];           // Starting point of the vector
    length = norm(vector - start); // Length of the vector
    x = vector[0];
    y = vector[1];
    z = vector[2];
    b = acos(z / length); // inclination angle
    c = atan2(y, x);      // azimuthal angle

    rotate([ 0, b, c ]) cylinder(h = length, r = 0.2);
    // % cube(vector); // corner of cube should coinciqde with end of cylin
}

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

module find_anchor(v)
{
    children(0);
    color("yellow") rotate(v) children(0);
}