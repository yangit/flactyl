#!/bin/bash
# see [here](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/FAQ#How_can_I_export_multiple_parts_from_one_script?) to understand how it works
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o ../../production/case/clay/left.stl clay.scad
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\" -o ../../production/case/clay/right.stl clay.scad
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"thumb\" -o ../../production/case/clay/thumb.stl clay.scad

