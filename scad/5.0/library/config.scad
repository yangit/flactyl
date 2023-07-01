$fa = $preview ? 12 : 1;
$fs = $preview ? 2 : 0.4;

choc_key_x = 18;
choc_key_y = 17;
fr4thickness = 1.6;
nnHeaderThikness = 4.4;
hotSwapThikness = 1.4;
pcbAndHotswapThikness = hotSwapThikness + fr4thickness;
caseThikness = 2.5;
wallOffsetFromPcb = 1;
wallOffsetFromConnector = 3;
tentingAngle = 60;
keysThikness = 11;
caseColor = "grey";
pcbColor = "darkgreen";
keysColor = "white";
screwBumpSize = 2.5;

niceNanoCutoutDepth = 8;
switchPlateCutout = 13.8;
switchPlateCutoutDepth = 2.2;
extensionWidth = 60 + (caseThikness + wallOffsetFromPcb) * 2;
extensionLength = 90;
extensionShift = 11 - caseThikness - wallOffsetFromPcb;
pcbWidth = 90;
cutter = 400;

ccFarWall = 120;
ccFrontWall = 5 + caseThikness;
ccBackWall = 58 + ccFrontWall + caseThikness;

magnetStripeWidth = 26;
magnetStripeDepth = 0.7;
// legs
legRubberDepth = 1;
legRubberDiameter = 8;
legsInsideDepth = caseThikness;
legsTotalThickness = caseThikness + legsInsideDepth + legRubberDepth;

// case to case mounting
screwHoleDiameter = 2.3;

stagger_pinky = 0;
stagger_ring = 17 + stagger_pinky;
stagger_middle = 3 + stagger_ring;
stagger_index = -6 + stagger_middle;
stagger_index2 = -3 + stagger_index;
rows = [ stagger_pinky, stagger_ring, stagger_middle, stagger_index, stagger_index2 ];