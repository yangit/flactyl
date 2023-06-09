include <../library/config.scad>;
use <../library/lib.scad>;

// rotate([ 0, tentingAngle + 180, 0 ]) wall(1, 200);
vPcb = [[ "r", [ 0, 180 - tentingAngle, 0 ] ]];
vTable = [];
vFront = [ [ "r", [ -90, 0, 0 ] ], [ "t", [ 0, 0, 0 ] ] ];
vBack = [ [ "r", [ 90, 0, 0 ] ], [ "t", [ 0, 0, -68 ] ] ];
vFar = [ [ "r", [ 0, -90, 0 ] ], [ "t", [ 0, 0, -110 ] ] ];
vTop = [ [ "r", [ 0, 180 - tentingAngle, 0 ] ], [ "t", [ -pcbWidth, 0, 0 ] ], [ "r", [ 0, 90, 0 ] ] ];
vThumb = [];
moveRotateTranslate(vPcb) rotate([ 0, 180, 0 ]) left_pcb_dxf();

// moveRotateTranslate(vTop) showWall();
// echo(vPcb);
// echo(concat(vPcb));
difference()
{
    box([ vPcb, vFront, vBack, vFar, vTop ], [ vPcb, vTable, vFront, vBack, vFar, vTop ], caseThikness, cutter);
    anchor_thumb() cut(cutter);
    anchor_thumb() wall(cutter);
}