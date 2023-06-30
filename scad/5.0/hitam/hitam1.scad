include <../library/config.scad>;
include <../library/lib.scad>;
include <./config/thumbConfig2.scad>;
stagger_pinky = 0;
stagger_ring = 17 + stagger_pinky;
stagger_middle = 3 + stagger_ring;
stagger_index = -6 + stagger_middle;
stagger_index2 = -3 + stagger_index;
rows = [ stagger_pinky, stagger_ring, stagger_middle, stagger_index, stagger_index2 ];

vPcb = [[ "r", [ 0, 180 - tentingAngle, 0 ] ]];
vPcbMount = invertPlane(vPcb);
vTable = [];
vFront = [ [ "t", [ 0, 0, -frontEdge ] ], [ "r", [ -90, 0, 0 ] ] ];
vFront180 = invertPlane(vFront);
vBack = [ [ "r", [ 90, 180 - tentingAngle, 0 ] ], [ "t", [ 0, 60, 0 ] ] ];
// vBack2 = [ [ "r", [ 20, 10, 0 ] ], [ "t", [ -pcbWidth, 80, -68 ] ], [ "r", [ 90, 180 - tentingAngle, 0 ] ] ];

vMagnetBack = [ [ "t", [ 0, 0, -caseThikness * 2 - magnetStripeWidth + frontEdge ] ], [ "r", [ 90, 0, 0 ] ] ];
vMagnetBack180 = invertPlane(vMagnetBack);
vMagnetTop = [ [ "t", [ 0, 0, -magnetStripeDepth - caseThikness ] ], [ "r", [ 0, 180, 0 ] ] ];
vMagnetTop180 = invertPlane(vMagnetTop);
vFar = [
    [ "t", [ 0, 0, -100 ] ],
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
module left_pcbWell()
{
    offset(wallOffsetFromPcb) union()
    {
        left_keycaps_dxf();
        left_pcb_dxf();
    }
}
module left_pcbWell_cutter()
{
    moveRotateTranslate(vPcbMount) push(cutter, 0.001) left_pcbWell();
}
module thumb_pcbWell_cutter()
{ // thumb PCB cutout
    moveRotateTranslate(vThumb) push(cutter, pcbAndHotswapThikness + 0.01) offset(wallOffsetFromPcb) thumb_dxf();
}
module left_caseWalls()
{
    offset(caseThikness) left_pcbWell();
}

module nice_nano_cutout()
{
    // nice nano cutout
    moveRotateTranslate(vPcbMount) nice_nano_mount_to_pcb() push(10, 10) offset(wallOffsetFromPcb) projection()
        nice_nano();
};
// thumb slide to side cutout
module thumb_slide_left_cutter()
{
    moveRotateTranslate(vThumb) rotate([ -90, 0, 0 ]) push(10, cutter) offset(delta = 0.01) projection()
        rotate([ 90, 0, 0 ]) push(keysThikness + 20) offset(wallOffsetFromPcb) thumb_dxf();
}
module thumb_base_cutter()
{
    // thumb base cutter
    cut3d([ vTable, vBack ]) moveRotateTranslate(vThumb) translate([ 0, 0, -caseThikness + 0.01 ])
        cut3d([invertPlane(vTable)]) rotate([ 0, -thumbTiltAngle, 0 ]) push(cutter, cutter)
            rotate([ 0, thumbTiltAngle, 0 ]) offset(wallOffsetFromPcb) thumb_dxf();
}
module case_base_90_cutout()
{
    // case base 90 from table
    push(keysThikness + caseThikness + 0.01, 0.01) offset(delta = 0.001) projection(cut = true) moveRotateTranslate([
        [ "r", [ 0, tentingAngle, 0 ] ], [ "t", [ 0, 0, -caseThikness ] ], [ "r", [ 0, -tentingAngle, 0 ] ],
        [ "t", [ 0, 0, -caseThikness - keysThikness ] ]
    ]) rotate([ 0, tiltAngle - tentingAngle, 0 ]) cut3d([[[ "r", [ 0, 180 - tiltAngle, 0 ] ]]]) push(cutter, cutter)
        rotate([ 0, -tiltAngle, 0 ]) left_pcbWell();
}
module case_base_tilted_cutout()
{
    // case base tilted
    cut3d([[[ "t", [ 0, 0, keysThikness + caseThikness ] ]]]) moveRotateTranslate(
        [ [ "r", [ 0, tentingAngle, 0 ] ], [ "t", [ 0, 0, -caseThikness ] ], [ "r", [ 0, -tentingAngle, 0 ] ] ])
        rotate([ 0, tiltAngle - tentingAngle, 0 ]) cut3d([[[ "r", [ 0, 180 - tiltAngle, 0 ] ]]]) push(cutter, cutter)
            rotate([ 0, -tiltAngle, 0 ]) offset(delta = 0.001) left_pcbWell();
}
module usbc_cutout()
{
    // hole for USB-C nicenano connector
    moveRotateTranslate(vPcbMount) nice_nano_mount_to_pcb() rotate([ 0, -90, 0 ]) translate([ 0, 0, -24 ]) push(10, 100)
        offset(delta = wallOffsetFromConnector + 0.1) hull() projection(cut = true) translate(v = [ 0, 0, 32.5 ])
            rotate([ 0, 90, 0 ]) nice_nano();
}
module left_keys()
{
    for (row = [0:4])
    {
        for (i = [0:2])
        {
            color("white") moveRotateTranslate(
                concat([ [ "r", [ 0, 0, 90 ] ], [ "t", [ 7 + row * 18, 8.5 + rows[row] + i * 17, 3 ] ] ], vPcbMount))

                import("../shared-3d-models/choc-hot.3mf");
        }
    }
}
module thumb_keys()
{

    for (row = [0:1])
    {
        for (i = [0:2])
        {
            color("white") moveRotateTranslate(
                concat([ [ "r", [ 0, 0, 90 ] ], [ "t", [ 9 + row * 18, 8.5 + i * 17, 3 ] ] ], vThumb))

                import("../shared-3d-models/choc-hot.3mf");
        }
    }
}
module hitam()
{
    color(caseColor) union()
    {
        // left plate
        render() difference()
        {
            union()
            {
                cut3d([vTable]) moveRotateTranslate(vPcbMount) push(-caseThikness) left_caseWalls();
                // add screw bumps
                cut3d([vThumb180]) moveRotateTranslate(vPcbMount) push(-caseThikness - screwBumpSize) left_screw_dxf();
            }
            nice_nano_cutout();
            thumb_slide_left_cutter();
            // subtract left screw holes
            moveRotateTranslate(vPcbMount) push(cutter, cutter) left_screw_holes_dxf();
            thumb_pcbWell_cutter();
            usbc_cutout();
        }
        // left keywell
        render() difference()
        {
            cut3d([vTable]) moveRotateTranslate(vPcbMount) push(keysThikness + pcbAndHotswapThikness) difference()
            {
                left_caseWalls();
                left_pcbWell();
            };
            thumb_pcbWell_cutter();
            usbc_cutout();
        }
        // case base 90 from table
        render() difference()
        {
            push(keysThikness + caseThikness) projection(cut = true) moveRotateTranslate([
                [ "r", [ 0, tentingAngle, 0 ] ], [ "t", [ 0, 0, -caseThikness ] ], [ "r", [ 0, -tentingAngle, 0 ] ],
                [ "t", [ 0, 0, -caseThikness - keysThikness ] ]
            ]) rotate([ 0, tiltAngle - tentingAngle, 0 ]) cut3d([[[ "r", [ 0, 180 - tiltAngle, 0 ] ]]])
                push(cutter, cutter) rotate([ 0, -tiltAngle, 0 ]) left_caseWalls();
            case_base_90_cutout();
            case_base_tilted_cutout();
        }
        // case base tilted
        render() difference()
        {
            color(caseColor) cut3d([[[ "t", [ 0, 0, keysThikness + caseThikness ] ]]]) moveRotateTranslate(
                [ [ "r", [ 0, tentingAngle, 0 ] ], [ "t", [ 0, 0, -caseThikness ] ], [ "r", [ 0, -tentingAngle, 0 ] ] ])
                rotate([ 0, tiltAngle - tentingAngle, 0 ]) cut3d([[[ "r", [ 0, 180 - tiltAngle, 0 ] ]]])
                    push(cutter, cutter) rotate([ 0, -tiltAngle, 0 ]) left_caseWalls();
            case_base_tilted_cutout();
            thumb_base_cutter();
            thumb_pcbWell_cutter();
            usbc_cutout();
        }

        // filler in the corner
        render() cut3d([vPcb]) difference()
        {
            rotate([ 0, -90, 0 ]) push(-11) projection(cut = true) translate([ 0, 0, 10 ]) rotate([ 0, 90, 0 ])
                push(keysThikness + caseThikness) left_caseWalls();
            rotate([ 0, -90, 0 ]) push(-21) projection(cut = true) translate([ 0, 0, 10 ]) rotate([ 0, 90, 0 ])
                push(keysThikness + caseThikness + 0.01, 0.01) left_pcbWell();
        }
        // thumb
        render() difference()
        {

            union()
            {
                vThumbKeyWellCutter = invertPlane(concat(
                    // prepare
                    [[ "t", [ 0, 0, keysThikness + pcbAndHotswapThikness - 5 ] ]], [[ "r", [ 0, 80, -90 ] ]], ,
                    // rotation
                    sequenceRotateFn([ thumbXRotation, thumbYRotation, thumbZRotation ]),
                    // translation
                    [[ "t", [ thumbXOffset, thumbYOffset, thumbZOffset ] ]]));
                // thumb keywell
                cut3d([vThumbKeyWellCutter]) moveRotateTranslate(vThumb) push(keysThikness + pcbAndHotswapThikness)
                    difference()
                {
                    offset(wallOffsetFromPcb + caseThikness) thumb_dxf();
                    offset(wallOffsetFromPcb) thumb_dxf();
                };
                // thumb plate
                difference()
                {
                    moveRotateTranslate(vThumb) union()
                    {
                        push(-caseThikness) offset(wallOffsetFromPcb + caseThikness) thumb_dxf();
                        // screw bumps
                        push(-caseThikness - screwBumpSize) thumb_screw_dxf();
                    }
                    nice_nano_cutout();

                    // thumb screw holes
                    moveRotateTranslate(vThumb) push(0.01, caseThikness + 0.01) thumb_screw_holes_dxf();
                }
            }
            left_pcbWell_cutter();
            thumb_slide_left_cutter();
        }
        // thumb base
        render() difference()
        {
            cut3d([ vTable, vBack ]) moveRotateTranslate(vThumb) translate([ 0, 0, -caseThikness ])
                cut3d([invertPlane(vTable)]) rotate([ 0, -thumbTiltAngle, 0 ]) push(cutter, cutter)
                    rotate([ 0, thumbTiltAngle, 0 ]) offset(wallOffsetFromPcb + caseThikness) thumb_dxf();
            nice_nano_cutout();
            left_pcbWell_cutter();
            thumb_base_cutter();
            case_base_90_cutout();
            case_base_tilted_cutout();
        }
    }
}
// Some export magic, look into ./build.sh
if (PARTNO == undef)
{
    left_keys();
    thumb_keys();
    hitam();
    moveRotateTranslate(vPcbMount) nice_nano_mount_to_pcb() nice_nano();
    color(pcbColor) moveRotateTranslate(vPcbMount) left_pcb();
    color(pcbColor) moveRotateTranslate(vThumb) thumb_pcb();
}
else
{
    if (PARTNO == "left")
        hitam();
    if (PARTNO == "right")
        mirror([ 1, 0, 0 ]) hitam();

    if (KEYS == true)
    {
        color(pcbColor) moveRotateTranslate(vPcbMount) left_pcb();
        left_keys();
        thumb_keys();
        color(pcbColor) moveRotateTranslate(vThumb) thumb_pcb();
    }
}