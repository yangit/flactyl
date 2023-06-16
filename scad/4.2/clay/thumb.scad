include <../library/config.scad>;
use <../library/lib.scad>;
tlegDepth = 20;
tlegThickness = 5;
tlegOffset = 5;
thumbClusterWidth = 51;
thumbClusterHeight = 36;

module thumb_clay_leg()
{
    union()
    {
        push(tlegDepth) square(tlegThickness, center = true);
        translate([ 0, 0, tlegDepth ]) linear_extrude(height = tlegThickness, scale = -10)
            square(tlegThickness, center = true);
    }
}
module thumb()
{
    union()
    {
        push(caseThikness) difference()
        {
            thumb_dxf();
            thumb_screw_holes_dxf();
        }
        push(caseThikness + screwBumpSize) thumb_screw_dxf();
        translate([ tlegOffset + tlegThickness / 2, tlegOffset + tlegThickness / 2, 0 ]) thumb_clay_leg();
        translate([ thumbClusterHeight - tlegOffset - tlegThickness / 2, tlegOffset + tlegThickness / 2, 0 ])
            thumb_clay_leg();

        translate([ tlegOffset + tlegThickness / 2, thumbClusterWidth - tlegOffset - tlegThickness / 2, 0 ])
            thumb_clay_leg();
        translate([
            thumbClusterHeight - tlegOffset - tlegThickness / 2, thumbClusterWidth - tlegOffset - tlegThickness / 2, 0
        ]) thumb_clay_leg();
    }
}