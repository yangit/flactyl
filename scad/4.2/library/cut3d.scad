include <../library/config.scad>;
use <../library/lib.scad>;

vPcb = [[ "r", [ 0, 180 - tentingAngle, 0 ] ]];
vTable = [];

cut3d([ vPcb, vTable ]) cube(200, center = true);