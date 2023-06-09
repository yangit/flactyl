include <./config.scad>;
use <./lib.scad>;

// Here is an example how to build any hollow box

vTop = [ [ "t", [ 0, 0, 40 ] ], [ "r", [ 160, 0, 0 ] ] ];
vBack = [ [ "t", [ 0, 100, 0 ] ], [ "r", [ 90, 0, 0 ] ] ];
vLeft = [ [ "t", [ -50, 0, 0 ] ], [ "r", [ 0, 90, 0 ] ] ];
vBottom = [ [ "t", [ 0, 0, 0 ] ], [ "r", [ 0, 0, 0 ] ] ];
vFront = [ [ "t", [ 0, -10, 0 ] ], [ "r", [ -90, 0, 0 ] ] ];
vRight = [ [ "t", [ 50, 0, 0 ] ], [ "r", [ 0, -90, 0 ] ] ];

color("red") moveRotateTranslate(vTop) showWall();
color("green") moveRotateTranslate(vBack) showWall();
color("blue") moveRotateTranslate(vLeft) showWall();
color("pink") moveRotateTranslate(vBottom) showWall();
color("white") moveRotateTranslate(vFront) showWall();
color("black") moveRotateTranslate(vRight) showWall();

box([ vTop, vBack, vLeft, vBottom, vRight ], [ vTop, vBack, vLeft, vBottom, vFront, vRight ], caseThikness, cutter);