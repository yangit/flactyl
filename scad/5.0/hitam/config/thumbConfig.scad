thumbTiltAngle = 22;
tiltAngle = 25;
thumbXOffset = 49;
thumbYOffset = 28;
thumbZOffset = 71;
thumbXRotation = -20;
thumbYRotation = 35;
thumbZRotation = -10;
frontEdge = 0;
rounding = caseThikness + wallOffsetFromPcb + 1.5;
farEdge = 95.3;
version = "Ice v5.0 var2";
legs = [
    // back left
    [ 8, 72 - legRubberDiameter / 2 - caseThikness - wallOffsetFromPcb ],
    // front left
    [ 8, 5 ],
    // front right
    [ farEdge - legRubberDiameter / 2 - caseThikness - wallOffsetFromPcb, 13 ],
    // back right
    [
        farEdge - legRubberDiameter / 2 - caseThikness - wallOffsetFromPcb, 66 - legRubberDiameter / 2 - caseThikness -
        wallOffsetFromPcb
    ],
];

vPcb = [[ "r", [ 0, 180 - tentingAngle, 0 ] ]];
vPcbMount = invertPlane(vPcb);
vTable = [];
vFront = [ [ "t", [ 0, 0, -frontEdge ] ], [ "r", [ -90, 0, 0 ] ] ];
vFront180 = invertPlane(vFront);
vBack = [ [ "r", [ 90, 180 - tentingAngle, 0 ] ], [ "t", [ 0, 60, 0 ] ] ];
// vBack2 = [ [ "r", [ 20, 10, 0 ] ], [ "t", [ -pcbWidth, 80, -68 ] ], [ "r", [ 90, 180 - tentingAngle, 0 ] ] ];

vMagnetBack = [ [ "t", [ 0, 0, -caseThikness * 2 - magnetStripeWidth + frontEdge ] ], [ "r", [ 90, 0, 0 ] ] ];
vMagnetBack180 = invertPlane(vMagnetBack);
vMagnetTop = [ [ "t", [ 0, 0, -magnetStripeDepth - caseThikness ] ], [ "r", [ 0, 180, 0 ] ] ];
vMagnetTop180 = invertPlane(vMagnetTop);
vFar = [
    [ "t", [ 0, 0, -100 ] ],
    [ "r", [ 0, -110, -10 ] ],
];
vTop = [ [ "r", [ 0, 90, 0 ] ], [ "t", [ -pcbWidth - caseThikness, 0, 0 ] ], [ "r", [ 0, 180 - tentingAngle, 0 ] ] ];
// vTop2 = [ [ "r", [ 15, 100, 0 ] ], [ "t", [ -pcbWidth, 60, 40 ] ], [ "r", [ 0, 180 - tentingAngle, 0 ] ] ];
vTop2 = [ [ "r", [ 35, 110, 10 ] ], [ "t", [ -pcbWidth, 60, 30 ] ], [ "r", [ 0, 180 - tentingAngle, 0 ] ] ];
// moveRotateTranslate(vTop2) showWall();
vThumb = concat(
    // prepare
    [[ "r", [ 0, 90, -90 ] ]],
    // rotation
    sequenceRotateFn([ thumbXRotation, thumbYRotation, thumbZRotation ]),
    // translation
    [[ "t", [ thumbXOffset, thumbYOffset, thumbZOffset ] ]]);
vThumbMirror = concat(
    // a
    [[ "t", [ 0, -51, 0 ] ]],
    // b
    [[ "r", [ 0, 90, -90 ] ]],
    // c
    sequenceRotateFn([ thumbXRotation, -thumbYRotation, -thumbZRotation ]),
    // d
    [[ "t", [ -thumbXOffset, thumbYOffset, thumbZOffset ] ]]

);

vThumb180 = invertPlane(vThumb);