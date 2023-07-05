include <../library/config.scad>;
include <../library/lib.scad>;
include <./config/thumbConfig.scad>;
// left_pcb();
// left_keys();
// thumb_pcb();
// thumb_keys();
// thumb3_pcb();
// thumb3_keys();
// moveRotateTranslate(moveThumbToCorner) thumb3_screw_holes_dxf();
moveRotateTranslate([
    //
    [ "t", [ -choc_key_x * 1.5, -choc_key_y, 0 ] ]
    //
    ,
    // [ "r", [ 180, 180, 0 ] ]
    [ "r", [ 0, 0, 90 ] ]
    //
    ,
    // [ "t", [ 0, choc_key_y * 1.5, 0 ] ]
]) thumb3_screw_holes_dxf();
translate([ 0, 80, 0 ]) thumb3_screw_holes_dxf();
// union()
// {
//     // difference()
//     // {
//     //     push(-caseThikness) thumb_dxf();
//     //     push(0.01, caseThikness + 0.01) thumb_screw_holes_combined_dxf();
//     // }
//     push(-screwBumpSize - caseThikness) thumb_screw_combined_dxf();
// }

//     // push(4, 3) thumb_screw_holes_dxf();
//     // push(4, 3) thumb3_screw_holes_dxf();
//     push(4, 3) thumb_screw_holes_combined_dxf();
// }

// intersection()
// {

// translate([ 0, 0, -hotSwapThikness - fr4thickness ]) wall(hotSwapThikness, 20);
// color("#696969") moveRotateTranslate([ [ "r", [ 90, 0, 90 ] ], [ "t", [ -6, 10, -1.3 ] ] ])
//     import("../shared-3d-models/pg1350_socket.3mf");
// }