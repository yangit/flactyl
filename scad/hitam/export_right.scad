include <../library/config.scad>;
use <../library/lib.scad>;
use <./case.scad>;
$fa = 1;
$fs = 0.4;

translate([ 300, 0, 0 ]) mirror([ 1, 0, 0 ]) case ();