#!/bin/bash
# see [here](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/FAQ#How_can_I_export_multiple_parts_from_one_script?) to understand how it works
EXPORTDIR=../../../production/case/5.1/iceberg
# time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o $EXPORTDIR/left.stl iceberg.scad
# time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\" -o $EXPORTDIR/right.stl iceberg.scad

sed -e "s/thumbConfig1.scad/thumbConfig2.scad/" iceberg1.scad > iceberg2.scad
mkdir -p $EXPORTDIR/variant1
mkdir -p $EXPORTDIR/variant2
for i in {1..2}
do
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o $EXPORTDIR/variant$i/left.stl iceberg$i.scad
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\" -o $EXPORTDIR/variant$i/right.stl iceberg$i.scad

    # inside
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o $EXPORTDIR/variant$i/case1.png --imgsize=800,600 --camera=40,60,20,70,0,40,400 iceberg$i.scad
    # inside with keys
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=true -o $EXPORTDIR/variant$i/case2.png --imgsize=800,600 --camera=40,60,20,70,0,40,400 iceberg$i.scad
    # outside
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o $EXPORTDIR/variant$i/case3.png --imgsize=800,600 --camera=80,60,20,70,0,-40,400 iceberg$i.scad
    # outside with keys
    time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=true -o $EXPORTDIR/variant$i/case4.png --imgsize=800,600 --camera=80,60,20,70,0,-40,400 iceberg$i.scad

    sips -s format jpeg $EXPORTDIR/variant$i/case1.png --out $EXPORTDIR/variant$i/case1.jpg
    sips -s format jpeg $EXPORTDIR/variant$i/case2.png --out $EXPORTDIR/variant$i/case2.jpg
    sips -s format jpeg $EXPORTDIR/variant$i/case3.png --out $EXPORTDIR/variant$i/case3.jpg
    sips -s format jpeg $EXPORTDIR/variant$i/case4.png --out $EXPORTDIR/variant$i/case4.jpg

    rm $EXPORTDIR/variant$i/case1.png
    rm $EXPORTDIR/variant$i/case2.png
    rm $EXPORTDIR/variant$i/case3.png
    rm $EXPORTDIR/variant$i/case4.png
done

rm iceberg2.scad

