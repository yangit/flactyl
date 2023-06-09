include <../library/config.scad>;
use <../library/lib.scad>;

legs = [
    [ 5, 69 - legRubberDiameter / 2 - caseThikness ], [ 5, 6 ], [ ccFarWall - legRubberDiameter / 2 - caseThikness, 6 ],
    [ ccFarWall - legRubberDiameter / 2 - caseThikness, 69 - legRubberDiameter / 2 - caseThikness ]
];

// rotate([ 0, tentingAngle + 180, 0 ]) wall(1, 200);
vPcb = [[ "r", [ 0, 180 - tentingAngle, 0 ] ]];
vPcbMount = [[ "r", [ 0, -tentingAngle, 0 ] ]];
vTable = [];
vFront = [ [ "r", [ -90, 0, 0 ] ], [ "t", [ 0, 0, 0 ] ] ];
vBack = [ [ "r", [ 90, 0, 0 ] ], [ "t", [ 0, 0, -68 ] ] ];
vFar = [ [ "r", [ 0, -90, 0 ] ], [ "t", [ 0, 0, -ccFarWall ] ] ];
vTop = [ [ "r", [ 0, 175 - tentingAngle, 0 ] ], [ "t", [ -pcbWidth + 21, 0, 0 ] ], [ "r", [ 0, 90, 0 ] ] ];
// vTop = [ [ "r", [ 180, 0, 0 ] ], [ "t", [ 0, 0, -50 ] ] ];
vThumb = [ [ "t", [ 0, -10, 0 ] ], [ "r", [ 230, 0, 0 ] ] ];
vMiniWall = [ [ "r", [ 190, 0, 0 ] ], [ "t", [ 0, 0, -4 ] ] ];

render()
{
    cut3d([ vThumb, vPcb ]) difference()
    {

        union()
        {

            box([ vPcb, vBack ], [ vPcb, vTable, vFront, vBack, vFar, vTop ], caseThikness, cutter);
            // add bottom with cutout for magnet holder
            difference()
            {
                cut3d([ vFar, vPcb, vFront, vBack ]) wall(caseThikness + magnetStripeDepth, cutter);
                // magnet stripe cutout

                translate([ caseThikness, caseThikness, 0 ])
                    cube([ ccFarWall - caseThikness * 2, magnetStripeWidth, magnetStripeDepth ]);
            }
            // add legs
            for (i = legs)
            {
                // leg hole support
                translate([ i[0], i[1] ]) push(caseThikness + legsInsideDepth + legRubberDepth)
                    circle(r = (legRubberDiameter + 3) / 2);
            }
            // add mini support wall at the far edge
            cut3d([ vTable, vBack, vFront, vMiniWall ]) moveRotateTranslate(vFar) wall(caseThikness, cutter);
            // add screw bumps
            moveRotateTranslate(vPcbMount) push(-caseThikness - screwBumpSize) left_screw_dxf();
        }

        // nice nano cutout
        moveRotateTranslate(vPcbMount) nice_nano_mount_to_pcb() push(10, 10) offset(wallOffsetFromPcb) projection()
            nice_nano();
        // subtract screw holes
        moveRotateTranslate(vPcbMount) push(20, 20) left_screw_holes_dxf();
        // add legs holes
        for (i = legs)
        {
            translate([ i[0], i[1] ]) push(legRubberDepth) circle(d = (legRubberDiameter + 1));
        }
    }
}

anchor_pcb() left_pcb_dxf();