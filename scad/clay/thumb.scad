include <../library/config.scad>;
use <../library/lib.scad>;
legDepth = 22;
legThickness = 5;
legOffset = 5;
thumbClusterWidth = 51;
thumbClusterHeight = 36;

module anchorLeft()
{
    translate([ thumbClusterHeight / 2, legOffset + legThickness / 2, 0 ]) children(0);
}
module anchorRight()
{
    translate([ thumbClusterHeight / 2, thumbClusterWidth - legThickness / 2 - legOffset, 0 ]) children(0);
}
union()
{
    push(caseThikness) difference()
    {
        thumb_dxf();
        thumb_screw_holes_dxf();
    }

    push(legDepth) anchorLeft() square(legThickness, center = true);
    push(legDepth) anchorRight() square(legThickness, center = true);

    translate([ 0, 0, legDepth ]) anchorLeft() linear_extrude(height = legThickness, scale = -10)
        square(legThickness, center = true);
    translate([ 0, 0, legDepth ]) anchorRight() linear_extrude(height = legThickness, scale = -10)
        square(legThickness, center = true);
}