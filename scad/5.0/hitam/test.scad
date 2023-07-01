include <../library/config.scad>;
include <../library/lib.scad>;
include <./config/thumbConfig.scad>;

left_pcb();
left_keys();

// intersection()
// {

// translate([ 0, 0, -hotSwapThikness - fr4thickness ]) wall(hotSwapThikness, 20);
// color("#696969") moveRotateTranslate([ [ "r", [ 90, 0, 90 ] ], [ "t", [ -6, 10, -1.3 ] ] ])
//     import("../shared-3d-models/pg1350_socket.3mf");
// }