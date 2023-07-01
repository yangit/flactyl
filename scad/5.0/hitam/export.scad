include <../library/config.scad>;
include <../library/lib.scad>;
include <./config/thumbConfig.scad>;

if (PARTNO == "left")
    color(caseColor) import("./build/left.stl");
if (PARTNO == "right")
    color(caseColor) import("./build/right.stl");

if (KEYS == true)
{
    moveRotateTranslate(vPcbMount) left_pcb();
    moveRotateTranslate(vPcbMount) left_keys();
    moveRotateTranslate(vThumb) thumb_keys();
    moveRotateTranslate(vThumb) thumb_pcb();
}