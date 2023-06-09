module push(x)
{
    if (x > 0)
    {
        linear_extrude(x) children(0);
    }
    else
    {
        translate([ 0, 0, x ]) linear_extrude(x * -1) children(0);
    }
}
push(10) wall(2, 200);