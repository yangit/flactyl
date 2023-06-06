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
// module mk()
// {
//     push(10) square([ 10, 10 ]);
// }

// // simple cube
// color("green") translate([ 20, 0, 0 ]) mk();

// // create smaller copy manually
// difference()
// {
//     color("lightgreen") translate([ 0, 20, 0 ]) mk();
//     translate([ 1, 21, 1 ]) push(8) square([ 8, 8 ]);
//     push(1) projection() translate([ 0, 20, 0 ]) mk();
// }

// // scale
// difference()
// {
//     color("lightblue") translate([ 0, 40, 0 ]) mk();
//     translate([ 1, 41, 1 ]) scale([ 0.8, 0.8, 0.8 ]) mk();
//     push(1) projection() translate([ 0, 40, 0 ]) mk();
// }

// // minkovsky
// scale([ 0.9, 0.9, 0.9 ]) difference()
// {
//     minkowski()
//     {
//         mk();
//         sphere(r = 1);
//     }
//     mk();
//     // translate([ 0, 0, caseThikness ]) mk();
//     push(-100) square([ 100, 100 ]);
// }

// // piece by piece
// module t4()
// {
//     translate([ -15, 0, 0 ]) children(0);
// }
// wall = 1;

// t4() union()
// {
//     cube([ wall, 10, 10 ]);
//     cube([ 10, wall, 10 ]);
//     cube([ 10, 10, wall ]);
//     translate([ 0, 0, 9 ]) cube([ 10, 10, wall ]);
//     translate([ 0, 9, 0 ]) cube([ 10, wall, 10 ]);
// }

// wall by wall

thick = 1;
size = 40;
module bo()
{
    translate([ 20, 0, -5 ]) children(0);
}
module l()
{
    translate([ 20, 5, 0 ]) rotate([ 90, 0, 0 ]) children(0);
}
module r()
{
    translate([ 20, -5, 0 ]) rotate([ 90, 0, 0 ]) children(0);
}
module f()
{
    translate([ 20 - 5, 0, 0 ]) rotate([ 0, 90, 0 ]) children(0);
}
module ba()
{
    translate([ 20 + 5, 0, 0 ]) rotate([ 0, 90, 0 ]) children(0);
}
module t()
{
    translate([ 20, 0, +5 ]) children(0);
}

difference()
{
    union()
    {
        bo() wall(thick, size);
        l() wall(thick, size);
        r() wall(thick, size);
        f() wall(thick, size);
        ba() wall(thick, size);
        t() wall(thick, size);
    }
    t() cut(size);
}
// translate([ 20, 0, 0 ]) rotate([ 0, 90, 0 ]) wall(thick, size);
// translate([ 20, 0, 0 ]) wall(thick, size);