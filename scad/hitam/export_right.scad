
include <./config.scad>;
use <./case.scad>;
use <./lib.scad>;
$fa = 1;
$fs = 0.4;

translate([ 300, 0, 0 ]) mirror([ 1, 0, 0 ]) case ();