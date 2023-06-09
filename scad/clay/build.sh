#!/bin/bash
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"left\" -o ../../production/case/clay/left.stl clay.scad
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"right\" -o ../../production/case/clay/right.stl clay.scad
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -DPARTNO=\"thumb\" -o ../../production/case/clay/thumb.stl clay.scad

