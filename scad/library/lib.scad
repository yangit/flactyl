include <./config.scad>;

// This function is limited to 11 elements!
function unshift(vec) = [ vec[1], vec[2], vec[3], vec[4], vec[5], vec[6], vec[7], vec[8], vec[9], vec[10], vec[11] ];

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
// This function is limited to 11 elements!
function unshift(vec) = [ vec[1], vec[2], vec[3], vec[4], vec[5], vec[6], vec[7], vec[8], vec[9], vec[10], vec[11] ];

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

// Sorry some black magic here, I do not understand it myself
// You can take a look at rotate.scad to see how it works
// this funciton returns a list of rotations that will rotate a vector around x, y and z axis
// it does more than just sequential rotate() rotate() rotate() because it keeps the
// objects relative rotation axis instead of always rotating around [0,0,0] origin.
function sequenceRotateFn(vector) = [
    // x
    [ "r", [ 1, 0, 0 ] * vector[0] ],
    // y
    [ "r", [ 0, cos(vector[0]), sin(vector[0]) ] * vector[1] ],
    // z
    [ "r", [ sin(vector[1]), -sin(vector[0]) * cos(vector[1]), cos(vector[0]) * cos(vector[1]) ] * vector[2] ]
];

// Allows to rotate a vector around the x, y and z axis while keeping original object rotation axis
// very usefull to rotate something around certain point in human readable format
// normal rotate() module stops being sane after second rotation
// i.e. rotate() rotate() rotate() will yield unexpected results if you are rotating for non 90 degree angles

module sequenceRotate(vector)
{
    x = vector[0];
    y = vector[1];
    z = vector[2];
    xVector = [ 1, 0, 0 ];
    yVector = [ 0, cos(x), sin(x) ];
    zVector = [ sin(y), -sin(x) * cos(y), cos(x) * cos(y) ];
    rotate(a = z, v = zVector) rotate(a = y, v = yVector) rotate(a = x, v = xVector) children(0);
}

// Same like linear_extrude but with negative parameters,
// and allows to extrude in both directions if you provide two parameters
module push(x, y)
{
    if (y == undef)
    {
        if (x > 0)
        {
            linear_extrude(x) children(0);
        }
        else
        {
            translate([ 0, 0, x ]) linear_extrude(x * -1) children(0);
        }
    }
    else
    {
        if (x > 0 && y > 0)
        {
            translate([ 0, 0, -y ]) linear_extrude(height = x + y) children(0);
        }
    }
}

// Utility module used to create shapes by cutting planes form them
// we can not cut a plane, but we can cut a sufficiently big cube, which is the same
module cut(size)
{

    if (size > 0)
    {
        push(size) square([ size, size ], center = true);
    }
    else
    {
        push(size) square([ -size, -size ], center = true);
    }
}

// given array of planes cut child nodes
module cut3d(planes)
{

    intersection()
    {
        children(0);
        intersection_for(i = planes)
        {

            moveRotateTranslate(i) cut(cutter);
        }
    }
}

// Utility module used to create walls
// usfull to create boxes
module wall(thikness, size)
{
    intersection()
    {
        cut(size);
        translate([ 0, 0, thikness ]) cut(-size);
    }
}

// Debug module to show the wall anchor
module showWall()
{
    union()
    {
        translate([ 0, 0, 15 ]) cube([ 1, 1, 30 ], center = true);
        rotate([ 0, 90, 0 ]) translate([ 0, 0, 5 ]) cube([ 1, 1, 10 ], center = true);
        rotate([ 90, 0, 0 ]) translate([ 0, 0, 5 ]) cube([ 1, 1, 10 ], center = true);
        sphere(r = 5);
    }
}

// Utility module to translate and rotate an object by a vector containing the translation and rotation values
//  if t=[10,0,0]
// and r = [90,0,0]
// moveRotateTranslate([["r",r],["t",t]]) is the same as translate(t) rotate(r)
// notice the reverse order of arguments.
// Except you can pass [["r",r],["t",t]] around as an argument and you can not pass "translate(t) rotate(r)" as an
// argument
// Limited to 11 elements
module moveRotateTranslate(rt)
{
    assert(len(rt) < 12, "rotation translation vector can not have more than 11 elements");
    if (rt[0] == undef)
    {
        children(0);
    }
    if (rt[0][0] == undef)
    {
        children(0);
    }
    else
    {
        if (rt[1] == undef)
        {
            if (rt[0][0] == "r")
            {
                rotate(rt[0][1]) children(0);
            }
            if (rt[0][0] == "t")
            {
                translate(rt[0][1]) children(0);
            }
        }
        else
        {
            if (rt[0][0] == "r")
            {
                moveRotateTranslate(unshift(rt)) rotate(rt[0][1]) children(0);
            }
            if (rt[0][0] == "t")
            {
                moveRotateTranslate(unshift(rt)) translate(rt[0][1]) children(0);
            }
        }
    }
}
function invertPlane(mrtVector) = concat([[ "r", [ 0, 180, 0 ] ]], mrtVector);
;

// see box.scad for usage and debug examples
// Can create convex shapes using planes
module box(walls, cutters, thikness, cutter)
{
    cut3d(concat(walls, cutters)) union()
    {
        for (i = walls)
        {
            moveRotateTranslate(i) wall(thikness, cutter);
        }
    }
}

// if you have .dxf file and want to find its anchor point that is very uesfull
//
//  find_anchor([ 90, 0, 0 ]) import("path/to/file.dxf");
//
//  try rotating around x, y and z axis by 90 and 180 to visually find the anchor point
module find_anchor(v)
{
    children(0);
    color("yellow") rotate(v) children(0);
}

module table()
{
    color("brown") translate([ -50, 0, -tableThikness ]) linear_extrude(tableThikness) square([ 300, 250 ]);
}

moveLeftToCorner = [ "t", [ 7, choc_key_y / 2, 0 ] ];
// LEFT
module left_pcb_dxf()
{
    // bottom left corner
    moveRotateTranslate([moveLeftToCorner]) import("../../production/pcbs/left/left_pcb_edgecut.dxf");
}
module left_keycaps_dxf()
{
    // bottom left corner
    moveRotateTranslate([moveLeftToCorner]) import("../../production/pcbs/left/left_keycaps.dxf");
}
module left_pcb_with_keys_dxf()
{
    // bottom left corner
    moveRotateTranslate([moveLeftToCorner]) import("../../production/pcbs/left/left_pcb_edgecut_with_keys.dxf");
}
module left_switch_cutouts_dxf()
{
    // bottom left corner
    moveRotateTranslate([moveLeftToCorner]) import("../../production/pcbs/left/left_switch_cutouts.dxf");
}
module left_screw_dxf()
{
    // bottom left corner
    moveRotateTranslate([moveLeftToCorner]) import("../../production/pcbs/left/left_screw.dxf");
}
module left_screw_holes_dxf()
{
    // bottom left corner
    moveRotateTranslate([moveLeftToCorner]) import("../../production/pcbs/left/left_screw_holes.dxf");
}
module left_pcb()
{
    color(pcbColor) linear_extrude(pcbAndHotswapThikness) left_pcb_dxf();
}

module left_keys()
{
    translate([ 0, 0, pcbAndHotswapThikness ]) color(keysColor) linear_extrude(keysThikness) left_keycaps_dxf();
}
module left_case()
{
    color("grey") translate([ 0, 0, -caseThikness ]) push(caseThikness) left_case_dxf();
}

// THUMB
moveThumbToCorner = [ "t", [ choc_key_x / 2, choc_key_y / 2, 0 ] ];
module thumb_dxf()
{
    moveRotateTranslate([moveThumbToCorner]) import("../../production/pcbs/thumb/thumb_pcb_edgecut.dxf");
}
module thumb_switch_cutouts_dxf()
{
    moveRotateTranslate([moveThumbToCorner]) import("../../production/pcbs/thumb/thumb_switch_cutouts.dxf");
}
module thumb_screw_dxf()
{
    moveRotateTranslate([moveThumbToCorner]) import("../../production/pcbs/thumb/thumb_screw.dxf");
}
module thumb_screw_holes_dxf()
{
    moveRotateTranslate([
        [ "t", [ -choc_key_x / 2, -choc_key_y, 0 ] ], [ "r", [ 0, 180, 0 ] ],
        [ "t", [ choc_key_x, choc_key_y * 1.5, 0 ] ]
    ]) import("../../production/pcbs/thumb/thumb_screw_holes.dxf");
}
module thumb_keycaps_dxf()
{
    // bottom left corner
    moveRotateTranslate([moveThumbToCorner]) import("../../production/pcbs/thumb/thumb_keycaps.dxf");
}
module thumb_pcb()
{
    color("lightgreen") linear_extrude(pcbAndHotswapThikness) thumb_dxf();
}

module thumb_keys()
{
    translate([ 0, 0, pcbAndHotswapThikness ]) color(keysColor) linear_extrude(keysThikness) thumb_keycaps_dxf();
}

// NNANO
module nice_nano_mount_to_pcb()
{
    // translate for the pcb anchor
    moveRotateTranslate([ [ "r", [ 180, 0, 90 ] ], [ "t", [ 86.6, 29, 0 ] ] ]) children(0);
}
module nice_nano()
{
    color("lightblue")
        // set anchor to bottom outermost corner hole of the pcb
        translate([ 15.24, -7.62, 6.3 ]) color(pcbColor) import("../shared-3d-models/nice-nano.stl");
}