include <./config.scad>;
module showVector(vector)
// showVector(vector = [ 10, 10, 10 ]);
{
    start = [ 0, 0, 0 ];           // Starting point of the vector
    length = norm(vector - start); // Length of the vector
    x = vector[0];
    y = vector[1];
    z = vector[2];
    b = acos(z / length); // inclination angle
    c = atan2(y, x);      // azimuthal angle

    rotate([ 0, b, c ]) cylinder(h = length, r = 0.2);
    // % cube(vector); // corner of cube should coinciqde with end of cylin
}

module gimbalRotate(vector)
{
    x = vector[0];
    y = vector[1];
    z = vector[2];
    xVector = [ 1, 0, 0 ];
    yVector = [ 0, cos(x), sin(x) ];
    zVector = [ sin(y), -sin(x) * cos(y), cos(x) * cos(y) ];
    rotate(a = z, v = zVector) rotate(a = y, v = yVector) rotate(a = x, v = xVector) children(0);
}
module push(x, y)
{
    if (y == undef)
    {
        if (x > 0)
        {
            linear_extrude(x) children(0);
        }
        else
        {
            translate([ 0, 0, x ]) linear_extrude(x * -1) children(0);
        }
    }
    else
    {
        if (x > 0 && y > 0)
        {
            translate([ 0, 0, -y ]) linear_extrude(height = x + y) children(0);
        }
    }
}

module find_anchor(v)
{
    children(0);
    color("yellow") rotate(v) children(0);
}

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
module left_keycaps_dxf()
{
    // bottom left corner
    translate([ 7, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/pcb/ergogen/output/left/left_keycaps.dxf");
}
module left_switch_cutouts_dxf()
{
    // bottom left corner
    translate([ 7, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/pcb/ergogen/output/left/left_switch_cutouts.dxf");
}
module left_screw_dxf()
{
    // bottom left corner
    translate([ 7, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/pcb/ergogen/output/left/left_screw.dxf");
}
module left_screw_holes_dxf()
{
    // bottom left corner
    translate([ 7, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/pcb/ergogen/output/left/left_screw_holes.dxf");
}
module thumb_dxf()
{
    // bottom left corner
    translate([ 9, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/case/scad/dxf/thumb_pcb_edgecut.dxf");
}
module thumb_switch_cutouts_dxf()
{
    // bottom left corner
    translate([ 9, 8.5, 0 ])
        import("/Users/y/Dropbox/github/flactyl/pcb/ergogen/output/thumb/thumb_switch_cutouts.dxf");
}
module thumb_screw_dxf()
{
    // bottom left corner
    translate([ 9, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/pcb/ergogen/output/thumb/thumb_screw.dxf");
}
module thumb_screw_holes_dxf()
{
    // bottom left corner
    translate([ 9, 8.5, 0 ]) import("/Users/y/Dropbox/github/flactyl/pcb/ergogen/output/thumb/thumb_screw_holes.dxf");
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
module nice_nano_mount_to_pcb()
{
    // translate for the pcb anchor
    translate([ 86.6, 29, 0 ]) rotate([ 180, 0, 90 ]) children(0);
}
module nice_nano()
{
    color("lightblue")

        // set anchor to bottom outermost corner hole of the pcb
        translate([ 15.24, -7.62, 6.3 ]) color(pcbColor)
            import("/Users/y/Dropbox/github/flactyl/case/scad/3d-models/nice-nano.stl");
}