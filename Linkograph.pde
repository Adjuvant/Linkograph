

ArrayList<DataPoint> items = new ArrayList<DataPoint>();

float pointSize = 10;
float pointSizeHalf = pointSize/2;

int numOfItems = 25;
float probability = 0.98;
float formFactorW = 13.0;
float drawableWidth, leftAnchor, rightAnchor;
float distributionFactor;

boolean reset = false;

boolean drawingRect = false;
boolean movingRect = false;
HighlightBox box;
PVector pMove, dMove;

DataPoint previousHit;

void setup() {
  size(1200, 600);
  smooth();

  ArrayList<DataUnit> data = parseData();
  //println(data.size());
  numOfItems = data.size();

  // Set design variables
  leftAnchor = width/formFactorW;
  rightAnchor =  width - leftAnchor;
  drawableWidth = rightAnchor - leftAnchor;
  distributionFactor = drawableWidth / ((float)numOfItems-1.0);

  for (int i = 0; i < numOfItems; i++) {
    items.add(new DataPoint(i, data.get(i)));
  }
}

void draw() {

  background(0);
  checkMousePressed();
  stroke(255);
  //line(leftAnchor, 20, rightAnchor, 20);
  //line(leftAnchor, 20, leftAnchor, height-20);
  //line(rightAnchor, 20, rightAnchor, height-20);
  for (int i = 1; i<(int)formFactorW; i++) {
    line (leftAnchor*(float)i, 15, leftAnchor*(float)i, 25);
  }

  if (box != null) {
    box.display();
  }
  for (DataPoint d : items) {
    d.update();
    d.display();
  }

  // noLoop();
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    reset = true;
  }
}

void keyReleased() {
  if (key == 'r' || key == 'R') {
    reset = false;
  }
}
/*
 check all points
 if hit ->
 */
