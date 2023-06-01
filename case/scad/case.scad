pcbAndHotswapThikness = 3;
caseThikness = 2.5;
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

color(caseColor) difference()
{
    union()
    {
        intersection()
        {
            // the case itself
            anchor_pcb() translate([ 0, 0, -200 ]) linear_extrude(200) left_case_dxf();
            // the case projection on the table
            linear_extrude(height = 200) projection(cut = false) anchor_pcb() linear_extrude(0.001) left_case_dxf();
        }
        // case extension for stability
        intersection()
        {
            // bottom
            translate([ 0, 11, 0 ]) linear_extrude(height = 200) square([ 90, 51 ]);
            // tented
            translate([ 0, 11, 0 ]) rotate([ 0, -tentingAngle, 0 ]) translate([ 0, 0, -200 ])
                linear_extrude(height = 200) square([ 90, 51 ]);
        }
    }
    // cutout for nice nano
    anchor_pcb() translate([ 0, 0, -niceNanoCutoutDepth ]) linear_extrude(height = 200) offset(delta = 1)
        projection(cut = false) nice_nano();
    // cutout for thumb cluster
    anchor_thumb() linear_extrude(height = 200) offset(delta = 1) thumb_dxf();
    // cutout for thumb cluster slide up
    anchor_thumb() rotate([ -90, -90, 0 ]) linear_extrude(height = 100) projection(cut = fsalse) rotate([ 90, 90, 0 ])
        linear_extrude(height = 100) thumb_dxf();
    // cutout for thumb cluster slide left
    anchor_thumb() rotate([ -90, 0, 0 ]) translate([ 0, 0, -100 ]) linear_extrude(height = 100) projection(cut = false)
        rotate([ 90, 0, 0 ]) linear_extrude(height = 100) offset(delta = 1) thumb_dxf();
}

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