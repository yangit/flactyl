include <../library/config.scad>;
include <../library/lib.scad>;
include <./config/thumbConfig.scad>;

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

module magnetCutter()
{
    union()
    {
        moveRotateTranslate([[ "t", [ caseThikness, -wallOffsetFromPcb, 0 ] ]]) push(magnetStripeDepth, 0.01) union()
        {
            offset(rounding) offset(-1 * rounding) square([ farEdge - caseThikness * 2, magnetStripeWidth ]);
            translate([ 0, rounding ]) square([ farEdge - caseThikness * 2, magnetStripeWidth - rounding ]);
        }
    }
}
module magnetHolder()
{
    color(caseColor) cut3d([vPcb]) difference()
    {
        moveRotateTranslate([[ "t", [ 0, -caseThikness - wallOffsetFromPcb, 0 ] ]])
            push(caseThikness + magnetStripeDepth) union()
        {
            offset(rounding) offset(-1 * rounding) square([ farEdge, magnetStripeWidth + caseThikness * 2 ]);
            translate([ 0, rounding ]) square([ farEdge, magnetStripeWidth + caseThikness * 2 - rounding ]);
        }
        magnetCutter();
    }
}

module legs()
{
    for (i = legs)
    {
        // leg hole support
        translate([ i[0], i[1] ]) push(caseThikness + legsInsideDepth + legRubberDepth)
            circle(r = (legRubberDiameter + 3) / 2);
    }
}
module legsCut()
{
    union()
    {
        // cut legs holes
        for (i = legs)
        {
            translate([ i[0], i[1] ]) push(legRubberDepth, 0.01) circle(d = (legRubberDiameter + 1));
        }
    }
}

module hitamMirrorable(mirrorCase)
{
    if (mirrorCase == 1)
    {
        color(caseColor) render() union()
        {
            difference()
            {
                mirror([ 1, 0, 0 ])
                {
                    hitam();
                }
                // screw holes
                moveRotateTranslate(vThumbMirror) push(1, caseThikness + 0.01) thumb_screw_holes_dxf();
            }

            // screw bumps
            moveRotateTranslate(vThumbMirror) push(-1 * (caseThikness + screwBumpSize)) thumb_screw_dxf();
        }
    }
    else
    {
        color(caseColor) render() union()
        {
            difference()
            {
                hitam();
                // screw holes
                moveRotateTranslate(vThumb) push(1, caseThikness + 0.01) thumb_screw_holes_dxf();
            }

            // screw bumps
            moveRotateTranslate(vThumb) push(-1 * (caseThikness + screwBumpSize)) thumb_screw_dxf();
        }
    }
}
module hitam()
{
    color(caseColor) union()
    {
        moveRotateTranslate(vPcbMount) translate([ 20, 62, 0 ]) rotate([ 180, 0, 0 ]) push(caseThikness + 1)
            text(version, size = 4);
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
            legsCut();
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
            magnetCutter();
            legsCut();
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
            legsCut();
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
                        // // screw bumps
                        // push(-caseThikness - screwBumpSize) thumb_screw_dxf();
                    }
                    nice_nano_cutout();

                    // thumb screw holes
                    // moveRotateTranslate(vThumb) push(0.01, caseThikness + 0.01) thumb_screw_holes_dxf();
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
        // magnet holder
        render() difference()
        {
            magnetHolder();
            legsCut();
        }
        // legs
        color(caseColor) cut3d([vPcb]) difference()
        {
            legs();
            legsCut();
        }
    }
}
// Some export magic, look into ./build.sh
if (PARTNO == undef)
{
    // the preview in openscad UI
    hitam();
    // color(pcbColor) moveRotateTranslate(vPcbMount) left_pcb();
    // color(pcbColor) moveRotateTranslate(vThumb) thumb_pcb();
    // moveRotateTranslate(vPcbMount) left_keys();
    // moveRotateTranslate(vThumb) thumb_keys();
    moveRotateTranslate(vPcbMount) nice_nano_mount_to_pcb() nice_nano();
}
else
{
    // the build.sh file
    if (PARTNO == "left")
    {
        hitamMirrorable(0);
    }
    if (PARTNO == "right")
    {
        hitamMirrorable(1);
    }
}