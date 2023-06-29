include <../library/config.scad>;
include <../library/lib.scad>;
include <./config/thumbConfig2.scad>;

vPcb = [[ "r", [ 0, 180 - tentingAngle, 0 ] ]];
vPcbMount = invertPlane(vPcb);
vTable = [];
vFront = [ [ "t", [ 0, 0, -frontEdge ] ], [ "r", [ -90, 0, 0 ] ] ];
vFront180 = invertPlane(vFront);
vBack = [ [ "r", [ 70, 180 - tentingAngle, 0 ] ], [ "t", [ 0, 68, 0 ] ] ];
vBack2 = [ [ "r", [ 20, 10, 0 ] ], [ "t", [ -pcbWidth, 80, -68 ] ], [ "r", [ 90, 180 - tentingAngle, 0 ] ] ];

vMagnetBack = [ [ "t", [ 0, 0, -caseThikness * 2 - magnetStripeWidth + frontEdge ] ], [ "r", [ 90, 0, 0 ] ] ];
vMagnetBack180 = invertPlane(vMagnetBack);
vMagnetTop = [ [ "t", [ 0, 0, -magnetStripeDepth - caseThikness ] ], [ "r", [ 0, 180, 0 ] ] ];
vMagnetTop180 = invertPlane(vMagnetTop);
vFar = [
    [ "t", [ 0, 0, -103 ] ],
    [ "r", [ 0, -110, -10 ] ],
];
vTop = [ [ "r", [ 0, 90, 0 ] ], [ "t", [ -pcbWidth - caseThikness, 0, 0 ] ], [ "r", [ 0, 180 - tentingAngle, 0 ] ] ];
// vTop2 = [ [ "r", [ 15, 100, 0 ] ], [ "t", [ -pcbWidth, 60, 40 ] ], [ "r", [ 0, 180 - tentingAngle, 0 ] ] ];
vTop2 = [ [ "r", [ 35, 110, 10 ] ], [ "t", [ -pcbWidth, 60, 30 ] ], [ "r", [ 0, 180 - tentingAngle, 0 ] ] ];
// moveRotateTranslate(vTop2) showWall();
vThumb = concat(
    // prepare
    [[ "r", [ 0, 90, -90 ] ]],
    // rotation
    sequenceRotateFn([ thumbXRotation, thumbYRotation, thumbZRotation ]),
    // translation
    [[ "t", [ thumbXOffset, thumbYOffset, thumbZOffset ] ]]);
vThumb180 = invertPlane(vThumb);

module legs()
{
    cut3d([ vPcb, vFar, vBack2, vBack, vFront, vThumb180 ]) union()
    {
        for (i = legs)
        {
            // leg hole support
            translate([ i[0], i[1] ]) push(caseThikness + legsInsideDepth + legRubberDepth)
                circle(r = (legRubberDiameter + 3) / 2);
        }
    }
}
module legsCut()
{
    union()
    {
        // cut legs holes
        for (i = legs)
        {
            translate([ i[0], i[1] ]) push(legRubberDepth) circle(d = (legRubberDiameter + 1));
        }
    }
}
module magnetHolder()
{
    box([ vFar, vPcb, vFront, vMagnetBack, vMagnetTop ], [vTable], caseThikness, cutter);
}
module flatLegs()
{
    box([ vBack, vFar, vPcb, vBack2 ], [ vMagnetTop, vTable, vMagnetBack180 ], caseThikness, cutter);
}
module iceberg()
{
    difference()
    {

        union()
        {

            // front part of the case
            difference()
            {
                // walls
                box([ vPcb, vFar, vTop ], [ vFront, vThumb180, vMagnetTop180, vBack2, vBack, vTop2 ], caseThikness,
                    cutter);
                // hole for thumb cluser
                moveRotateTranslate(vThumb) push(cutter, cutter) thumb3_dxf();
            }

            // walls
            box([ vBack2, vBack, vTop2 ], [ vMagnetTop180, vPcb, vFront, vFar, vTop, vThumb180 ], caseThikness, cutter);

            // add screw bumps
            cut3d([vThumb180]) moveRotateTranslate(vPcbMount) push(-caseThikness - screwBumpSize) left_screw_dxf();

            // thumb cluster
            union()
            {
                // thumb cluster backplate
                moveRotateTranslate(vThumb) push(-caseThikness) difference()
                {
                    thumb3_dxf();
                    thumb3_screw_holes_dxf();
                }
                // screw bumps
                moveRotateTranslate(vThumb) push(-1 * (caseThikness + screwBumpSize)) thumb3_screw_dxf();

                // walls under thumb cluster
                cut3d([vFront180]) moveRotateTranslate(vThumb) push(-cutter) difference()
                {
                    thumb3_dxf();
                    offset(-caseThikness) thumb3_dxf();
                }
            }
            magnetHolder();
            flatLegs();
            legs();
            moveRotateTranslate(vBack) push(caseThikness + 1) translate([ -60, 10, 0 ]) text(version, size = 4);
        }
        legsCut();
        // nice nano cutout
        moveRotateTranslate(vPcbMount) nice_nano_mount_to_pcb() push(10, 10) offset(wallOffsetFromPcb) projection()
            nice_nano();
        // subtract screw holes
        moveRotateTranslate(vPcbMount) push(1, caseThikness + screwBumpSize + 0.001) left_screw_holes_dxf();
        // hole for USB-C nicenano connector
        moveRotateTranslate(vPcbMount) nice_nano_mount_to_pcb() rotate([ 0, -90, 0 ]) translate([ 0, 0, -24 ])
            push(10, 100) offset(delta = wallOffsetFromConnector + 0.1) hull() projection(cut = true)
                translate(v = [ 0, 0, 32.5 ]) rotate([ 0, 90, 0 ]) nice_nano();
    }
}

module ploopy()
{
    moveRotateTranslate([[ "r", [ 90, 0, 180 ] ]]) union()
    {
        moveRotateTranslate([[ "t", [ 32, 32, 30.5 ] ]]) color("red") sphere(38.1 / 2);
        color("grey") import("../shared-3d-models/ploopy-nano/STLs/Bottom.stl");
        color("grey") moveRotateTranslate([[ "t", [ -1.5, 10.5, -1 ] ]])
            import("../shared-3d-models/ploopy-nano/STLs/Top.stl");
    }
}

trayThickness = 2;
trayWide = 80;
trayDeep = 80;
trayHigh = 20;
module tray()
{

    translate([ trayXOffset - trayWide / 2, trayYOffset - trayDeep / 2, 0 ]) difference()
    {
        cube([
            trayWide + trayThickness * 2, trayDeep + trayThickness * 2,
            trayHigh + magnetStripeDepth + caseThikness - 0.1
        ]);
        translate([ trayThickness, trayThickness, magnetStripeDepth + caseThikness ])
            cube([ trayWide, trayDeep, trayHigh ]);
    }
}
// Some export magic, look into ./build.sh
if (PARTNO == undef)
{
    // vIce = [ [ "t", [ 48, 41, 0 ] ], [ "r", [ 0, -tentingAngle, 0 ] ] ];
    // // color("blue") moveRotateTranslate(vIce) import("../../production/case/iceberg/left.stl");
    mirror([ 1, 0, 0 ])
    {
        *color(caseColor) render()
        {
            iceberg();
        };
        cut3d([vPcb]) tray();
        moveRotateTranslate([[ "t", [ 80, -trayDeep / 2 + 10 + trayYOffset, magnetStripeDepth + caseThikness ] ]])
            ploopy();
        moveRotateTranslate(vPcbMount) nice_nano_mount_to_pcb() nice_nano();
        color(pcbColor) moveRotateTranslate(vPcbMount) left_pcb();
        *color(keysColor) moveRotateTranslate(vPcbMount) left_keys();
        color(pcbColor) moveRotateTranslate(vThumb) thumb3_pcb();
        color(keysColor) moveRotateTranslate(vThumb) thumb3_keys();
    }
}
else
{
    if (PARTNO == "left")
        color(caseColor) iceberg();
    if (PARTNO == "right")
        color(caseColor) mirror([ 1, 0, 0 ]) iceberg();

    if (KEYS == true)
    {
        color(pcbColor) moveRotateTranslate(vPcbMount) left_pcb();
        color(keysColor) moveRotateTranslate(vPcbMount) left_keys();
        color(pcbColor) moveRotateTranslate(vThumb) thumb3_pcb();
        color(keysColor) moveRotateTranslate(vThumb) thumb3_keys();
    }
}