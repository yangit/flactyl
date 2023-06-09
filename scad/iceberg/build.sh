#!/bin/bash
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o ../../production/case/iceberg/left.stl iceberg.scad
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\" -o ../../production/case/iceberg/right.stl iceberg.scad

time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o ../../production/case/iceberg/left2.stl iceberg2.scad
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\" -o ../../production/case/iceberg/right2.stl iceberg2.scad

