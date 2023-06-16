include <./config.scad>;
use <./lib.scad>

difference()
{
    move_to_center = [ "t", [ -choc_key_x / 2, -choc_key_y, 0 ] ];
    move_to_corner = [ "t", [ choc_key_x / 2, choc_key_y / 2, 0 ] ];
    moveRotateTranslate([move_to_corner]) import("../../ergogen/output/thumb/thumb_pcb_edgecut.dxf");
    moveRotateTranslate([ move_to_center, [ "r", [ 0, 180, 0 ] ], [ "t", [ choc_key_x, choc_key_y * 1.5, 0 ] ] ])
        import("../../ergogen/output/thumb/thumb_screw_holes.dxf");
}

// import("../../ergogen/output/thumb/thumb_screw_holes.dxf");
// translate(tr) import("../../ergogen/output/thumb/thumb_pcb_edgecut.dxf");
// find_anchor(180) translate(tr) import("../../ergogen/output/thumb/thumb_pcb_edgecut.dxf");