include <./config.scad>;
// $fa = 1;
// $fs = 0.4;
use <./lib.scad>;
// color(caseColor)

module ccPcbAnchor()
{
    anchor_pcb() rotate([ 0, 180, 0 ]) children(0);
}
module ccTopAnchor()
{
    translate([ 0, 0, 107 ]) rotate([ 0, 270, 0 ]) anchor_pcb() children(0);
}
module ccFrontAnchor()
{
    translate([ 0, 5 + caseThikness, 0 ]) rotate([ 90, 0, 180 ]) children(0);
}

module ccBackAnchor()
{
    translate([ 0, 63 + caseThikness, 0 ]) rotate([ 90, 0, 0 ]) children(0);
}
module ccFarAnchor()
{
    rotate([ 0, 90, 0 ]) translate([ 0, 0, ccFarWall ]) rotate([ 0, 180, 0 ]) children(0);
}

module ccFrontWall()
{
    intersection()
    {

        ccFrontAnchor() wall(caseThikness, cutter);
        ccPcbAnchor() cut(cutter);
        ccTopAnchor() cut(cutter);
        ccFarAnchor() cut(cutter);
        cut(cutter);
    }
}
module ccBackWall()
{
    intersection()
    {

        ccBackAnchor() wall(caseThikness, cutter);
        ccPcbAnchor() cut(cutter);
        ccTopAnchor() cut(cutter);
        ccFarAnchor() cut(cutter);
        cut(cutter);
    }
}
module ccTopWall()
{
    intersection()
    {

        ccTopAnchor() wall(caseThikness, cutter);
        ccFarAnchor() cut(cutter);
        ccPcbAnchor() cut(cutter);
        ccFrontAnchor() cut(cutter);
        ccBackAnchor() cut(cutter);
    }
}
module ccFarWall()
{
    intersection()
    {

        ccFarAnchor() wall(caseThikness, cutter);
        ccTopAnchor() cut(cutter);
        ccFrontAnchor() cut(cutter);
        ccBackAnchor() cut(cutter);
        cut(cutter);
    }
}
module ccCase()
{

    ccTopWall();
    ccFrontWall();
    ccBackWall();
    ccFarWall();
}

// ccPcbAnchor() showWall();

module case (){
    color(caseColor)

        difference(){

            union(){

                difference(){

                    ccCase();

}
                // *difference(){

                //     union(){

                //         *intersection(){
                //             // cutter in the pcb plane
                //             anchor_pcb() push(-200) square(size = 400, center = true);
                //             // projection of the case on the table
                //             push(200) projection(cut = false) anchor_pcb() push(0.001)
                //                 offset(caseThikness + wallOffsetFromPcb) left_pcb_dxf();}
                //         // case extension for stability
                //         *
                //         intersection(){
                //             // bottom
                //             translate([ 0, extensionShift, 0 ]) push(200)
                //                 square([ extensionLength + caseThikness + wallOffsetFromPcb, extensionWidth ]);
                //             // tented
                //             translate([ 0, extensionShift, 0 ]) rotate([ 0, -tentingAngle, 0 ]) push(-200)
                //                 square([ extensionLength + caseThikness + wallOffsetFromPcb, extensionWidth ]);}}
                //     // cutout for thumb cluster slide left
                //     anchor_thumb() rotate([ -90, 0, 0 ]) push(-100) projection(cut = false) rotate([ 90, 0, 0 ])
                //         push(100) offset(delta = 1) thumb_dxf();}

                // left key well
                anchor_pcb() color(caseColor) push(keysThikness) difference(){

                    offset(caseThikness + wallOffsetFromPcb) left_pcb_dxf();

                    offset(wallOffsetFromPcb) left_pcb_dxf();}

                // left key baseplate
                union(){

                    difference(){

                        anchor_pcb() push(-caseThikness) offset(caseThikness + wallOffsetFromPcb) left_pcb_dxf();

                        anchor_thumb() rotate([ -90, 0, 0 ]) push(-100) projection(cut = false) rotate([ 90, 0, 0 ])
                            push(100) offset(delta = 1) thumb_dxf();

                        anchor_pcb() push(1, 1 + caseThikness) left_screw_holes_dxf();

}

                    anchor_pcb() push(-caseThikness - screwBumpSize) left_screw_dxf();}

                // thumb key well
                anchor_thumb() color(caseColor) difference(){

                    push(keysThikness) difference(){

                        offset(caseThikness + wallOffsetFromPcb) thumb_dxf();

                        offset(wallOffsetFromPcb) thumb_dxf();

}
                    // cutout for thumb cluster slide left
                    rotate([ -90, 0, 0 ]) push(-100) projection(cut = false) rotate([ 90, 0, 0 ]) push(100)
                        offset(delta = 1) thumb_dxf();}

                // thumb key baseplate
                union(){

                    difference(){

                        anchor_thumb() push(-caseThikness) offset(caseThikness + wallOffsetFromPcb) thumb_dxf();

                        anchor_thumb() push(1, 1 + caseThikness) thumb_screw_holes_dxf();

                        anchor_pcb() push(1, 3 + caseThikness) thumb_screw_holes_dxf();

}

                    anchor_thumb() push(-caseThikness - screwBumpSize) thumb_screw_dxf();}

                for (i = legs){
                    // leg hole support
                    translate([ i[0], i[1] ]) push(caseThikness + legsInsideDepth + legRubberDepth)
                        circle(r = (legRubberDiameter + 3) / 2);}}
            // cutout for nice nano side
            anchor_pcb() rotate([ -90, 0, 0 ]) translate([ 0, 0, 20 ]) push(20) projection(cut = false)
                rotate([ 90, 0, 0 ]) push(10, niceNanoCutoutDepth) offset(delta = wallOffsetFromPcb)
                    projection(cut = false) nice_nano_mount_to_pcb() nice_nano();

            // cutout for nice nano
            anchor_pcb() push(10, niceNanoCutoutDepth) offset(delta = wallOffsetFromPcb) projection(cut = false)
                nice_nano_mount_to_pcb() nice_nano();

            // cutout for nice nano connector
            anchor_pcb() nice_nano_mount_to_pcb() rotate([ 0, -90, 0 ]) translate([ 0, 0, -24 ]) push(-100)
                offset(delta = wallOffsetFromConnector) hull() projection(cut = true) translate(v = [ 0, 0, 32.5 ])
                    rotate([ 0, 90, 0 ]) nice_nano();

            // cutout for thumb cluster
            anchor_thumb() push(200) offset(delta = 1) thumb_dxf();
            // cutout for pcb
            anchor_pcb() push(200) offset(delta = 1) left_pcb_dxf();

            // leg holes
            for (i = legs){

                translate([ i[0], i[1] ]) push(legRubberDepth) circle(d = (legRubberDiameter + 1));

}
            // table cut
            cut(-cutter);
            anchor_pcb() push(200) offset(delta = wallOffsetFromPcb) left_keycaps_dxf();}}

case ();
// push(2) left_keycaps_dxf();
//     color("green") left_pcb_dxf();

// difference(){minkowski(){case (); sphere(r = 2 * caseThikness, 6);} translate([ 0, 0, caseThikness ]) case ();}

// anchor_pcb() difference(){left_pcb_dxf(); left_keycaps_dxf();}

// anchor_pcb() left_pcb();
// anchor_pcb() left_keys();
// anchor_pcb() nice_nano_mount_to_pcb() nice_nano();
// anchor_thumb() thumb_pcb();
// anchor_thumb() thumb_keys();

// find_anchor([ 0, 0, 0 ]) thumb_dxf();
// difference()
// {
//    anchor_pcb() left_pcb_case();
//     table();
// }

// // flat under case
// anchor_pcb() left_pcb_case();
// // rotate extrude case
// anchor_pcb() rotate([ -90, 0, 0 ]) rotate_extrude(angle = tentingAngle, $fn = 100) left_dxf();