include <./config.scad>;
use <./lib.scad>;

module movert1(rt)
{

    if (rt[0][0] == "r")
    {
        echo(rt);
        rotate(rt[0][1]) children(0);
    }
    if (rt[0][0] == "t")
    {
        echo(rt[0][1], rt[0][1]);
        translate(rt[0][1]) children(0);
    }
}
module movert(rt)
{

    if (rt[0][0] == "r")
    {
        rotate(rt[0][1]) movert1([rt[1]]) children(0);
    }
    if (rt[0][0] == "t")
    {
        translate(rt[0][1]) movert1([rt[1]]) children(0);
    }
}
module box(walls, cutters, thikness, cutter)
{
    for (i = walls)
    {
        difference()
        {
            movert(i) wall(thikness, cutter);
            for (i = cutters)
            {
                movert(i) cut(-cutter);
            }
        }
    }
}

vTop2 = [ [ "r", [ 10, 0, 0 ] ], [ "t", [ 0, 0, 40 ] ] ];
vTop = [ [ "r", [ 180, 0, 0 ] ], [ "t", [ 0, 0, 40 ] ] ];
vBack = [ [ "r", [ 90, 0, 0 ] ], [ "t", [ 0, 100, 0 ] ] ];
vLeft = [ [ "r", [ 0, 90, 0 ] ], [ "t", [ -50, 0, 0 ] ] ];
vBottom = [ [ "r", [ 0, 0, 0 ] ], [ "t", [ 0, 0, 0 ] ] ];
vFront = [ [ "r", [ -90, 0, 0 ] ], [ "t", [ 0, -10, 0 ] ] ];
vRight = [ [ "r", [ 0, -90, 0 ] ], [ "t", [ 50, 0, 0 ] ] ];
// movert([[ "t", [ 0, 0, 40 ] ]]) cube([ 10, 10, 10 ]);
movert(vTop2) cube([ 10, 10, 10 ]);
// movert1([vTop2[1]]) cube([ 10, 10, 10 ]);
// box([ vTop, vBack, vLeft, vBottom, vRight ], [ vTop, vBack, vLeft, vBottom, vFront, vRight ], caseThikness, cutter);