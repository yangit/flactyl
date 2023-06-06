pcbAndHotswapThikness = 3;
caseThikness = 2.5;
wallOffsetFromPcb = 1;
wallOffsetFromConnector = 3;
tentingAngle = 60;
tableThikness = 10;
keysThikness = 11;
caseColor = "grey";
pcbColor = "darkgreen";
keysColor = "white";
screwBumpSize = 2.5;
thumbXOffset = 49;
thumbYOffset = 28;
thumbZOffset = 71;
thumbXRotation = -20;
thumbYRotation = 35;
thumbZRotation = -10;
niceNanoCutoutDepth = 8;
switchCutout = 13.8;
switchCutoutDepth = 2.2;
extensionWidth = 60 + (caseThikness + wallOffsetFromPcb) * 2;
extensionLength = 90;
extensionShift = 11 - caseThikness - wallOffsetFromPcb;
cutter = 400;
ccFarWall = 110;
// legs
legRubberDepth = 1;
legRubberDiameter = 8;
legsInsideDepth = 5;
legs = [
    [ 5, 66 - legRubberDiameter / 2 - caseThikness ], [ 5, 13 ],
    [ ccFarWall - legRubberDiameter / 2 - caseThikness, 13 ],
    [ ccFarWall - legRubberDiameter / 2 - caseThikness, 66 - legRubberDiameter / 2 - caseThikness ]
];