include <../library/config.scad>;
use <../library/lib.scad>;
legDepth = 20;
legThickness = 5;
legOffset = 5;
thumbClusterWidth = 51;
thumbClusterHeight = 36;

module thumb_clay_leg()
{
    union()
    {
        push(legDepth) square(legThickness, center = true);
        translate([ 0, 0, legDepth ]) linear_extrude(height = legThickness, scale = -10)
            square(legThickness, center = true);
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
        translate([ legOffset + legThickness / 2, legOffset + legThickness / 2, 0 ]) thumb_clay_leg();
        translate([ thumbClusterHeight - legOffset - legThickness / 2, legOffset + legThickness / 2, 0 ])
            thumb_clay_leg();

        translate([ legOffset + legThickness / 2, thumbClusterWidth - legOffset - legThickness / 2, 0 ])
            thumb_clay_leg();
        translate(
            [ thumbClusterHeight - legOffset - legThickness / 2, thumbClusterWidth - legOffset - legThickness / 2, 0 ])
            thumb_clay_leg();
    }
}