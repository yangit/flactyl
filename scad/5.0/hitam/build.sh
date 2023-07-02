#!/bin/bash
MODEL=hitam
# see [here](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/FAQ#How_can_I_export_multiple_parts_from_one_script?) to understand how it works
EXPORTDIR=./build

mkdir -p $EXPORTDIR
echo "Building left side";
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o $EXPORTDIR/left.stl $MODEL.scad
echo "Building right side";
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\" -o $EXPORTDIR/right.stl $MODEL.scad

echo "Generating images";
# inside
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=false -o $EXPORTDIR/case1.png --imgsize=1600,1200 --camera=40,60,20,70,0,40,400 export.scad
# inside with keys
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=true -o $EXPORTDIR/case2.png --imgsize=1600,1200 --camera=40,60,20,70,0,40,400 export.scad
# outside
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=false -o $EXPORTDIR/case3.png --imgsize=1600,1200 --camera=80,60,20,70,0,-40,400 export.scad
# outside with keys
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=true -o $EXPORTDIR/case4.png --imgsize=1600,1200 --camera=80,60,20,70,0,-40,400 export.scad

#this is to convert png to jpg, works on Mac, you can skip it.
sips -s format jpeg $EXPORTDIR/case1.png --out $EXPORTDIR/case1.jpg
sips -s format jpeg $EXPORTDIR/case2.png --out $EXPORTDIR/case2.jpg
sips -s format jpeg $EXPORTDIR/case3.png --out $EXPORTDIR/case3.jpg
sips -s format jpeg $EXPORTDIR/case4.png --out $EXPORTDIR/case4.jpg

rm $EXPORTDIR/case1.png
rm $EXPORTDIR/case2.png
rm $EXPORTDIR/case3.png
rm $EXPORTDIR/case4.png

