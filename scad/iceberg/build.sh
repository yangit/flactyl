#!/bin/bash
# see [here](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/FAQ#How_can_I_export_multiple_parts_from_one_script?) to understand how it works
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o ../../production/case/iceberg/left.stl iceberg.scad
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\" -o ../../production/case/iceberg/right.stl iceberg.scad

time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o ../../production/case/iceberg/left2.stl iceberg2.scad
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\" -o ../../production/case/iceberg/right2.stl iceberg2.scad

