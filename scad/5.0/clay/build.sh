#!/bin/bash
# see [here](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/FAQ#How_can_I_export_multiple_parts_from_one_script?) to understand how it works

# EXPORTDIR=../../../production/case/5.0/clay
EXPORTDIR=./build
mkdir -p $EXPORTDIR
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=false -o $EXPORTDIR/left.stl clay.scad
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\"\;KEYS=false -o $EXPORTDIR/right.stl clay.scad
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"thumb\"\;KEYS=false -o $EXPORTDIR/thumb.stl clay.scad

# inside
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=false -o $EXPORTDIR/case1.png --imgsize=1600,1200 --camera=40,70,0,70,0,50,400 clay.scad
# inside with keys
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=true -o $EXPORTDIR/case2.png --imgsize=1600,1200 --camera=0,70,0,70,0,50,400 clay.scad
# outside
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\"\;KEYS=false -o $EXPORTDIR/case3.png --imgsize=1600,1200 --camera=60,50,0,70,0,-40,400 clay.scad
# thumb
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"thumb\"\;KEYS=false -o $EXPORTDIR/case4.png --imgsize=1600,1200 --camera=0,0,30,60,0,-40,200 clay.scad

sips -s format jpeg $EXPORTDIR/case1.png --out $EXPORTDIR/case1.jpg
sips -s format jpeg $EXPORTDIR/case2.png --out $EXPORTDIR/case2.jpg
sips -s format jpeg $EXPORTDIR/case3.png --out $EXPORTDIR/case3.jpg
sips -s format jpeg $EXPORTDIR/case4.png --out $EXPORTDIR/case4.jpg
rm $EXPORTDIR/case1.png
rm $EXPORTDIR/case2.png
rm $EXPORTDIR/case3.png
rm $EXPORTDIR/case4.png