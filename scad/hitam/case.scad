include <./config.scad>;
use <./lib.scad>;

module ccPcbAnchor()
{
    anchor_pcb() rotate([ 0, 180, 0 ]) children(0);
}
module ccTopAnchor()
{
    anchor_pcb() translate([ pcbWidth + caseThikness + wallOffsetFromPcb, 0, 0 ]) rotate([ 0, -90, 0 ]) children(0);
}
module ccFrontAnchor()
{
    translate([ 0, ccFrontWall, 0 ]) rotate([ 90, 0, 180 ]) children(0);
}

module ccBackAnchor()
{
    // translate([ 0, ccBackWall, 0 ]) rotate([ 90, 90 - tentingAngle, 20 ]) children(0);
    translate([ 0, ccBackWall, 0 ]) rotate([ 90, 90 - tentingAngle, 0 ]) children(0);
}

module ccFarAnchor()
{
    // rotate([ 0, 90, 0 ]) translate([ 0, 0, ccFarWall ]) rotate([ -10, 180, 0 ]) children(0);
    rotate([ 0, 90, 0 ]) translate([ 0, 0, ccFarWall ]) rotate([ 0, 180, 0 ]) children(0);
}

module ccFrontWall()
{
    intersection()
    {

        ccFrontAnchor() wall(caseThikness, cutter);
        ccPcbAnchor() cut(cutter);
        ccTopAnchor() cut(cutter);
        ccFarAnchor() cut(cutter);
        cut(cutter);
    }
}
module ccBackWall()
{
    intersection()
    {

        ccBackAnchor() wall(caseThikness, cutter);
        ccPcbAnchor() cut(cutter);
        ccTopAnchor() cut(cutter);
        ccFarAnchor() cut(cutter);
        cut(cutter);
    }
}
module ccTopWall()
{
    intersection()
    {

        ccTopAnchor() wall(caseThikness, cutter);
        ccFarAnchor() cut(cutter);
        ccPcbAnchor() cut(cutter);
        ccFrontAnchor() cut(cutter);
        ccBackAnchor() cut(cutter);
    }
}
module ccFarWall()
{
    intersection()
    {

        ccFarAnchor() wall(caseThikness, cutter);
        ccTopAnchor() cut(cutter);
        ccFrontAnchor() cut(cutter);
        ccBackAnchor() cut(cutter);
        cut(cutter);
    }
}
module ccMagnetHolder()
{
    difference()
    {
        intersection()
        {

            wall(caseThikness + magnetStripeDepth, cutter);
            ccFrontAnchor() cut(cutter);
            ccFarAnchor() cut(cutter);
            ccPcbAnchor() cut(cutter);
            translate([ 0, magnetStripeWidth + caseThikness * 2, 0 ]) ccFrontAnchor() cut(-cutter);
            // ccBackAnchor() cut(cutter);
        }
        translate([ 0, ccFrontWall + caseThikness, -0.001 ]) cube([ ccFarWall, magnetStripeWidth, magnetStripeDepth ]);
    }
}
module ssBackAnchor()
{
    translate([ 0, 30, 0 ]) ccBackAnchor() children(0);
}
module ssPcbAnchor()
{
    ccPcbAnchor() translate([ 0, 0, pcbWidth - 40 ]) children(0);
}

module ssTop()
{
    intersection()
    {
        ccTopAnchor() wall(caseThikness, cutter);
        ccFrontAnchor() cut(cutter);
        ccFarAnchor() cut(cutter);
        ssPcbAnchor() cut(cutter);
        ssBackAnchor() cut(cutter);
    }
}

module ssFar()
{
    intersection()
    {
        ccFarAnchor() wall(caseThikness, cutter);
        ccFrontAnchor() cut(cutter);
        ccTopAnchor() cut(cutter);
        ssBackAnchor() cut(cutter);
        cut(cutter);
    }
}

module ccCase()
{

    ccTopWall();
    ccFrontWall();
    ccBackWall();
    ccFarWall();
    ccMagnetHolder();
    ssFar();
    ssTop();
}

// ccPcbAnchor() showWall();

module case (){
    color(caseColor)

        difference(){

            union(){

                ccCase();

                // left key well
                anchor_pcb() color(caseColor) push(keysThikness+ pcbAndHotswapThikness) difference(){
                    union() {
                    offset(caseThikness + wallOffsetFromPcb) left_pcb_with_keys_dxf();
                    }

                    offset(wallOffsetFromPcb) left_pcb_with_keys_dxf();
                }

                // left key baseplate
                union(){
                    difference(){

                        anchor_pcb() push(-caseThikness) offset(caseThikness + wallOffsetFromPcb) left_pcb_with_keys_dxf();

                        anchor_thumb() rotate([ -90, 0, 0 ]) push(-100) projection(cut = false) rotate([ 90, 0, 0 ])
                            push(100) offset(delta = 1) thumb_dxf();
}

                    anchor_pcb() push(-caseThikness - screwBumpSize) left_screw_dxf();}

                // thumb key well
                anchor_thumb() color(caseColor) difference(){

                    push(keysThikness+ pcbAndHotswapThikness) difference(){

                        offset(caseThikness + wallOffsetFromPcb) thumb_dxf();

                        offset(wallOffsetFromPcb) thumb_dxf();

}
                    // cutout for thumb cluster slide left
                    rotate([ -90, 0, 0 ]) push(10,100) projection(cut = false) rotate([ 90, 0, 0 ]) push(100)
                        offset(delta = 1) thumb_dxf();}

                // thumb key baseplate
                union(){

                    difference(){

                        anchor_thumb() push(-caseThikness) offset(caseThikness + wallOffsetFromPcb) thumb_dxf();

}

                    anchor_thumb() push(-caseThikness - screwBumpSize) thumb_screw_dxf();}

                for (i = legs){
                    // leg hole support
                    translate([ i[0], i[1] ]) push(caseThikness + legsInsideDepth + legRubberDepth)
                        circle(r = (legRubberDiameter + 3) / 2);}
                        
                        }
            // power switch cutout
            intersection() {
                
                anchor_pcb() translate([ 26,1, -2.5 ]) sphere(10);
                rotate([0,90-tentingAngle,0]) translate([0,0,19+caseThikness]) cut(cutter);
            }

            // reset button access
            rotate([ 0, 90 - tentingAngle, 0 ]) translate([ -0.001, ccBackWall, 48 ]) cube([ caseThikness * 3, 10, 100 ]);

            // cutout thumb screw holes
            anchor_thumb() push(1, 3 + caseThikness) thumb_screw_holes_dxf();
            // cutout for nice nano side
            anchor_pcb() rotate([ -90, 0, 0 ]) translate([ 0, 0, 20 ]) push(20) projection(cut = false)
                rotate([ 90, 0, 0 ]) push(10, niceNanoCutoutDepth) offset(delta = wallOffsetFromPcb)
                    projection(cut = false) nice_nano_mount_to_pcb() nice_nano();

            // cutout for nice nano
            anchor_pcb() push(10, niceNanoCutoutDepth) offset(delta = wallOffsetFromPcb) projection(cut = false)
                nice_nano_mount_to_pcb() nice_nano();

            // cutout for nice nano connector
            anchor_pcb() nice_nano_mount_to_pcb() rotate([ 0, -90, 0 ]) translate([ 0, 0, -24 ]) push(-100)
                offset(delta = wallOffsetFromConnector) hull() projection(cut = true) translate(v = [ 0, 0, 32.5 ])
                    rotate([ 0, 90, 0 ]) nice_nano();
            
            // left screw holes
            anchor_pcb() push(10, 10 + caseThikness) left_screw_holes_dxf();
            
            // cutout for thumb cluster
            anchor_thumb() push(200) offset(delta = 1) thumb_dxf();
            

            // cutout for pcb
            anchor_pcb() push(200) offset(delta = 1) left_pcb_with_keys_dxf();



// cutout for thumb cluster slide up 
anchor_thumb() translate([ 0, 0, keysThikness + pcbAndHotswapThikness]) rotate([ 0, -90, 0 ]) push(cutter,5) projection(cut = false)
    rotate([ 0, 90, 0 ]) push(100) offset(delta = 1) thumb_dxf();
            // leg holes
            for (i = legs){

                translate([ i[0], i[1] ]) push(legRubberDepth) circle(d = (legRubberDiameter + 1));

}
            // table cut
            cut(-cutter);
            anchor_pcb() push(200) offset(delta = wallOffsetFromPcb) left_keycaps_dxf();
            
            
            // screw holes front and back
            for (i = [2:10])
{
    ccFrontAnchor() translate([ -10 * i, 10, 0 ]) push(cutter, cutter) circle(d = screwHoleDiameter);
}

// screw holes far
for (i = [1:5])
{
    ccFarAnchor() translate([ 10, ccFrontWall + 10 * i, 0 ]) push(caseThikness + 1, caseThikness + 1)
        circle(d = screwHoleDiameter);
}
}
}

// case ();
// ccCase();

// color(pcbColor) push(pcbAndHotswapThikness) left_pcb_dxf();
// color("red") push(-pcbAndHotswapThikness) left_pcb_with_keys_dxf();
// anchor_pcb() color(keysColor) translate([ 0, 0, pcbAndHotswapThikness ]) push(keysThikness) left_keycaps_dxf();

// color(caseColor) push(keysThikness + pcbAndHotswapThikness) difference()
// {
//     union()
//     {
//         offset(caseThikness + wallOffsetFromPcb) left_pcb_with_keys_dxf();
//     }

//     offset(wallOffsetFromPcb) left_pcb_with_keys_dxf();
// }
// translate([ 87 + caseThikness + wallOffsetFromPcb, 0, 0 ]) rotate([ 0, 90, 0 ]) wall(caseThikness, cutter);

// find_anchor(90) left_pcb_with_keys_dxf();

// find_anchor(180) left_pcb_dxf();
// translate([ 87 + caseThikness + wallOffsetFromPcb, 0, 0 ]) rotate([ 0, 90, 0 ]) wall(caseThikness, cutter);

// color("green") push(-2) offset(caseThikness + wallOffsetFromPcb) left_pcb_with_keys_dxf();
// color(caseColor) push(caseThikness) left_pcb_dxf();
// translate([ 90 + caseThikness + wallOffsetFromPcb, 0, 0 ]) rotate([ 0, -90, 0 ]) wall(caseThikness, cutter);