#!/bin/bash
MODEL=hitam
# see [here](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/FAQ#How_can_I_export_multiple_parts_from_one_script?) to understand how it works
EXPORTDIR=../../../production/case/5.0/$MODEL

sed -e "s/thumbConfig1.scad/thumbConfig2.scad/" $MODEL1.scad > $MODEL2.scad
mkdir -p $EXPORTDIR/variant1
mkdir -p $EXPORTDIR/variant2
for i in {1..2}
do
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o $EXPORTDIR/variant$i/left.stl $MODEL$i.scad
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\" -o $EXPORTDIR/variant$i/right.stl $MODEL$i.scad

    # inside
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o $EXPORTDIR/variant$i/case1.png --imgsize=800,600 --camera=40,60,20,70,0,40,400 $MODEL$i.scad
    # inside with keys
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=true -o $EXPORTDIR/variant$i/case2.png --imgsize=800,600 --camera=40,60,20,70,0,40,400 $MODEL$i.scad
    # outside
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o $EXPORTDIR/variant$i/case3.png --imgsize=800,600 --camera=80,60,20,70,0,-40,400 $MODEL$i.scad
    # outside with keys
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=true -o $EXPORTDIR/variant$i/case4.png --imgsize=800,600 --camera=80,60,20,70,0,-40,400 $MODEL$i.scad

    sips -s format jpeg $EXPORTDIR/variant$i/case1.png --out $EXPORTDIR/variant$i/case1.jpg
    sips -s format jpeg $EXPORTDIR/variant$i/case2.png --out $EXPORTDIR/variant$i/case2.jpg
    sips -s format jpeg $EXPORTDIR/variant$i/case3.png --out $EXPORTDIR/variant$i/case3.jpg
    sips -s format jpeg $EXPORTDIR/variant$i/case4.png --out $EXPORTDIR/variant$i/case4.jpg

    rm $EXPORTDIR/variant$i/case1.png
    rm $EXPORTDIR/variant$i/case2.png
    rm $EXPORTDIR/variant$i/case3.png
    rm $EXPORTDIR/variant$i/case4.png
done

rm $MODEL2.scad

