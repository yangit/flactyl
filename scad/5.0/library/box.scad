include <./config.scad>;
use <./lib.scad>;

// Here is an example how to build any hollow box
// First we define a list of planes, and tha those planes will be used to create walls and cut the excess

vTop = [ [ "r", [ 160, 0, 0 ] ], [ "t", [ 0, 0, 40 ] ] ];
vBack = [ [ "r", [ 90, 0, 0 ] ], [ "t", [ 0, 100, 0 ] ] ];
vLeft = [ [ "r", [ 0, 90, 0 ] ], [ "t", [ -50, 0, 0 ] ] ];
vBottom = [ [ "r", [ 0, 0, 0 ] ], [ "t", [ 0, 0, 0 ] ] ];
vFront = [ [ "r", [ -90, 0, 0 ] ], [ "t", [ 0, -10, 0 ] ] ];
vRight = [ [ "r", [ 0, -90, 0 ] ], [ "t", [ 50, 0, 0 ] ] ];

color("red") moveRotateTranslate(vTop) showWall();
color("green") moveRotateTranslate(vBack) showWall();
color("blue") moveRotateTranslate(vLeft) showWall();
color("pink") moveRotateTranslate(vBottom) showWall();
color("white") moveRotateTranslate(vFront) showWall();
color("black") moveRotateTranslate(vRight) showWall();

box([ vTop, vBack, vLeft, vBottom, vRight ], [vFront], caseThikness, cutter);