include <../library/config.scad>;
use <../library/lib.scad>;
use <./thumb.scad>
caseThikness = 3;
legs = [
    [ 5, 69 - legRubberDiameter / 2 - caseThikness ], [ 5, 6 ], [ ccFarWall - legRubberDiameter / 2 - caseThikness, 6 ],
    [ ccFarWall - legRubberDiameter / 2 - caseThikness, 69 - legRubberDiameter / 2 - caseThikness ]
];

vPcb = [[ "r", [ 0, 180 - tentingAngle, 0 ] ]];
vPcbMount = [[ "r", [ 0, -tentingAngle, 0 ] ]];
vTable = [];
vFront = [ [ "t", [ 0, 0, 0 ] ], [ "r", [ -90, 0, 0 ] ] ];
vBack = [ [ "t", [ 0, 0, -68 ] ], [ "r", [ 90, 0, 0 ] ] ];
vFar = [ [ "t", [ 0, 0, -ccFarWall ] ], [ "r", [ 0, -90, 0 ] ] ];
vTop = [ [ "r", [ 0, 90, 0 ] ], [ "t", [ -pcbWidth + 21, 0, 0 ] ], [ "r", [ 0, 175 - tentingAngle, 0 ] ] ];
vThumb = [ [ "r", [ 230, 0, 0 ] ], [ "t", [ 0, -10, 0 ] ] ];
vMiniWall = [ [ "t", [ 0, 0, -4 ] ], [ "r", [ 190, 0, 0 ] ] ];
vSupportTop = [ [ "r", [ 0, 90, 0 ] ], [ "t", [ -35, 0, 0 ] ], [ "r", [ 0, 235 - tentingAngle, 0 ] ] ];

module clay()
{
    cut3d([ vThumb, vPcb ]) difference()
    {

        union()
        {

            box([ vPcb, vBack ], [ vTable, vFront, vFar, vTop ], caseThikness, cutter);
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
                translate([ i[0], i[1] ]) push(caseThikness) circle(d = (legRubberDiameter + 3));
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

// Some export magic, look into ./build.sh
if (PARTNO == undef)
{
    color(caseColor) translate([ 0, -100, 0 ]) thumb();
    color(caseColor) clay();
    color(pcbColor) moveRotateTranslate(vPcbMount) left_pcb_dxf();
    color(keysColor) moveRotateTranslate(vPcbMount) left_keys();
}
else
{
    if (PARTNO == "thumb")
        thumb();
    if (PARTNO == "left")
        clay();
    if (PARTNO == "right")
        mirror([ 1, 0, 0 ]) clay();
}