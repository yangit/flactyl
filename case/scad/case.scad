pcbAndHotswapThikness = 3;
caseThikness = 2.5;
wallOffsetFromPcb = 1;
tentingAngle = 60;
tableThikness = 10;
keysThikness = 11;
caseColor = "grey";
pcbColor = "darkgreen";
keysColor = "white";
thumbXOffset = 49;
thumbYOffset = 28;
thumbZOffset = 71;
thumbXRotation = -20;
thumbYRotation = 35;
thumbZRotation = -10;
niceNanoCutoutDepth = 8;
switchCutout = 13.8;
switchCutoutDepth = 2.2;
// legs
legRubberDepth = 1;
legRubberDiameter = 8;
legs = [ [ 5, 66 ], [ 5, 2 ], [ 88, 17 ], [ 88, 56 ] ];

// $fa = 1;
// $fs = 0.4;
use <./lib.scad>;

module anchor_thumb()
{
    translate([ thumbXOffset, thumbYOffset, thumbZOffset ])
        gimbalRotate([ thumbXRotation, thumbYRotation, thumbZRotation ]) rotate([ 0, 90, -90 ]) children(0);
}
module anchor_pcb()
{
    rotate([ 0, -tentingAngle, 0 ]) children(0);
}
module table()
{
    color("brown") translate([ -50, 0, -tableThikness ]) linear_extrude(tableThikness) square([ 300, 250 ]);
}
module left_case_dxf()
{
    // bottom left corner
    translate([ 7, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/case/scad/dxf/left_case.dxf");
}
module left_pcb_dxf()
{
    // bottom left corner
    translate([ 7, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/case/scad/dxf/left_pcb_edgecut.dxf");
}
module left_cutouts_dxf()
{
    // bottom left corner
    translate([ 7, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/pcb/ergogen/output/left/left_switch_cutouts.dxf");
}
module left_keycaps_dxf()
{
    // bottom left corner
    translate([ 7, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/pcb/ergogen/output/left/left_keycaps.dxf");
}
module thumb_dxf()
{
    // bottom left corner
    translate([ 9, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/case/scad/dxf/thumb_pcb_edgecut.dxf");
}
module thumb_pcb()
{
    color("lightgreen") linear_extrude(pcbAndHotswapThikness) thumb_dxf();
}
module left_pcb()
{
    color(pcbColor) linear_extrude(pcbAndHotswapThikness) left_pcb_dxf();
}
module left_keys()
{
    translate([ 0, 0, pcbAndHotswapThikness ]) color(keysColor) linear_extrude(keysThikness) left_pcb_dxf();
}
module left_case()
{
    color("grey") translate([ 0, 0, -caseThikness ]) linear_extrude(caseThikness) left_case_dxf();
}
module thumb_keys()
{
    translate([ 0, 0, pcbAndHotswapThikness ]) color(keysColor) linear_extrude(keysThikness) thumb_dxf();
}
module nice_nano()
{
    color("lightblue")
        // translate for the pcb anchor
        translate([ 86.6, 29, 0 ]) rotate([ 180, 0, 90 ])
        // set anchor to bottom outermost corner hole of the pcb
        translate([ 15.24, -7.62, 6.3 ]) color(pcbColor)
            import("/Users/y/Dropbox/github/flactyl/case/scad/3d-models/nice-nano.stl");
}
module case (){
    color(caseColor)
        difference(){union(){difference(){union(){intersection(){
            // cutter in the pcb plane
            anchor_pcb() translate(v = [ 0, 0, -200 ]) linear_extrude(height = 200) square(size = 400, center = true);
            // projection of the case on the table
            linear_extrude(height = 200) projection(cut = false) anchor_pcb() linear_extrude(0.001)
                offset(caseThikness + wallOffsetFromPcb) left_pcb_dxf();}
                                                  // case extension for stability
                                                  intersection(){
                                                      // bottom
                                                      translate([ 0, 11, 0 ]) linear_extrude(height = 200)
                                                          square([ 90 + caseThikness + wallOffsetFromPcb, 51 ]);
                                                      // tented
                                                      translate([ 0, 11, 0 ]) rotate([ 0, -tentingAngle, 0 ])
                                                          translate([ 0, 0, -200 ]) linear_extrude(height = 200)
                                                              square([ 90 + caseThikness + wallOffsetFromPcb, 51 ]);}}
                                          // cutout for thumb cluster slide left
                                          anchor_thumb() rotate([ -90, 0, 0 ]) translate([ 0, 0, -100 ])
                                              linear_extrude(height = 100) projection(cut = false) rotate([ 90, 0, 0 ])
                                                  linear_extrude(height = 100) offset(delta = 1) thumb_dxf();}
                             // left key well
                             anchor_pcb() color(caseColor) linear_extrude(keysThikness)
                                 difference(){offset(caseThikness + wallOffsetFromPcb) left_pcb_dxf();
                                              offset(wallOffsetFromPcb) left_pcb_dxf();}
                             // thumb key well
                             anchor_thumb() color(caseColor) linear_extrude(keysThikness)
                                 difference(){offset(caseThikness + wallOffsetFromPcb) thumb_dxf();
                                              offset(wallOffsetFromPcb) thumb_dxf();} anchor_thumb()
                                     translate([ 0, 0, -caseThikness ]) linear_extrude(height = caseThikness)
                                         offset(caseThikness + wallOffsetFromPcb) thumb_dxf();
                             for (i = legs){

                                 // leg hole support
                                 translate([ i[0], i[1] ]) linear_extrude(caseThikness + legRubberDepth)
                                     circle(r = (legRubberDiameter + 3) / 2);}}
                     // cutout for nice nano
                     anchor_pcb() translate([ 0, 0, -niceNanoCutoutDepth ]) linear_extrude(height = 200)
                         offset(delta = 1) projection(cut = false) nice_nano();

                     // cutout for nice nano side
                     anchor_pcb() rotate([ -90, 0, 0 ]) translate([ 0, 0, 10 ]) linear_extrude(height = 100) hull()
                         offset(delta = wallOffsetFromPcb) projection(cut = false) rotate([ 90, 0, 0 ]) nice_nano();

                     // cutout for thumb cluster
                     anchor_thumb() linear_extrude(height = 200) offset(delta = 1) thumb_dxf();
                     // cutout for pcb
                     anchor_pcb() linear_extrude(height = 200) offset(delta = 1) left_pcb_dxf();

                     for (i = legs){
                         // leg hole
                         translate([ i[0], i[1] ]) linear_extrude(height = legRubberDepth)
                             circle(r = (legRubberDiameter + 1) / 2);}
                     // // cutout for thumb cluster slide up
                     // anchor_thumb() rotate([ -90, -90, 0 ]) linear_extrude(height = 100) projection(cut = fsalse)
                     // rotate([ 90, 90,

                     // ])
                     //     linear_extrude(height = 100) thumb_dxf();

                     // table cut
                     translate(v = [ 0, 0, -200 ]) linear_extrude(height = 200) square(size = 400, center = true);
                     anchor_pcb() linear_extrude(height = 200) offset(delta = wallOffsetFromPcb) left_keycaps_dxf();}}

//
case ();

// difference(){minkowski(){case (); sphere(r = 2 * caseThikness, 6);} translate([ 0, 0, caseThikness ]) case ();}

// difference(){left_pcb_dxf(); left_cutouts_dxf();}
// difference(){lefqt_pcb_dxf(); left_keycaps_dxf();}

// anchor_pcb() left_pcb();
// anchor_pcb() left_keys();
// anchor_pcb() nice_nano();
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