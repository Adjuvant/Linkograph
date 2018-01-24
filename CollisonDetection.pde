void checkMousePressed() {
  PVector mIn = new PVector(mouseX, mouseY);
  if (mousePressed) {
    if (!drawingRect) {
      manageHits(mIn);
    } else {    
      updateBox(mIn);
    }
  }

  if (!mousePressed) {
    if (drawingRect) 
      drawingRect = false;
    if (movingRect)       
      stopBox();

    if (previousHit != null) {
      previousHit.setOff();
      previousHit = null;
    }
  }
}

void startBox(PVector mIn) {
  println("Draw box");
  drawingRect = true;
  box = new HighlightBox(mIn);
}

void updateBox(PVector mIn) {
  println("Update box");
  box.update(mIn);
  for ( DataPoint d : items) {
    if (checkBoxHit (d.p.x, d.p.y) ) {
      box.addDataPoint(d);
    } else {
      box.removeDataPoint(d);
    }
  }
}

void moveBox(PVector mIn) {
  println("Move box");
  box.movePosition(mIn);
}

void stopBox() {
  println("Move box");
  movingRect = false;
  box = null;
}

void manageHits(PVector mIn) {
  DataPoint hit = null;
  // Check previous hit for collision first, as it is most likely, avoids cycling through all items.
  if (previousHit != null && checkPreviousCollision(mIn, previousHit)) {
    hit = previousHit;
  } else if (box != null && checkBoxHit (mIn.x, mIn.y) && !movingRect) {
    // Move stuff
    println("Start moving rect");
    movingRect = true;
    box.centerMode();
  } else if (box != null && checkBoxHit (mIn.x, mIn.y) && movingRect) {
    moveBox(mIn);
  } else {

    for ( DataPoint d : items) {
      if (checkMouseCollision(mIn, d)) {
        // Takes first hit and runs
        hit = d;
        break;
      }
    }
    if (box != null && !checkBoxHit (mIn.x, mIn.y))
      movingRect = false;
  }
   // problem here, does it all need to be nested?
  if (!movingRect) {
    if (hit != null) {
      // Delete box as it is there but not pressed
      if (box != null)
        box = null;

      if (hit != previousHit) {
        if (previousHit != null)
          previousHit.setOff();
        previousHit = hit;
      }
      if (!hit.isPressed())
        hit.setOn();
    } else if (previousHit != null) {
      previousHit.setOff();
      previousHit = null;
    } else {
      if (box == null)
        startBox(mIn);
    }
  }
}

boolean checkMouseCollision (PVector mouseIn, DataPoint dataIn ) {
  return pointBall(mouseIn.x, mouseIn.y, dataIn.p.x, dataIn.p.y, pointSize);
}
// Much larger hit radius to account for movement, 
boolean checkPreviousCollision (PVector mouseIn, DataPoint dataIn ) {
  return pointBall(mouseIn.x, mouseIn.y, dataIn.p.x, dataIn.p.y, pointSize*6.0);
}

boolean checkBoxHit(float x, float y) {
  return circleRect(x, y, pointSize, box.getStartX(), box.getStartY(), box.getWidth(), box.getHeight());
}

// Adapt form to statics or classes to be implemented by each type of interactable.
boolean pointBall(float px, float py, float bx, float by, float bSize) {

  // find distance between the two objects
  float xDist = px-bx;                                   // distance horiz
  float yDist = py-by;                                   // distance vert
  float distance = sqrt((xDist*xDist) + (yDist*yDist));  // diagonal distance

  // test for collision
  if (bSize > distance) { // Original:  if (bSize/2 > distance) {
    return true;    // if a hit, return true
  } else {            // if not, return false
    return false;
  }
}

/* 
 RECT/BALL COLLISION FUNCTION
 Jeff Thompson // v0.9 // November 2011 // www.jeffreythompson.org
 
 Takes 7 arguments:
 + x,y position of the first ball - in this case "you"
 + width and height of rect
 + x,y position of the second ball
 + diameter of second ball
 
 */
// CIRCLE/RECTANGLE
boolean circleRect(float cx, float cy, float radius, float rx, float ry, float rw, float rh) {

  // temporary variables to set edges for testing
  float testX = cx;
  float testY = cy;

  // which edge is closest?
  if (cx < rx)         testX = rx;        // compare to left edge
  else if (cx > rx+rw) testX = rx+rw;     // right edge
  if (cy < ry)         testY = ry;        // top edge
  else if (cy > ry+rh) testY = ry+rh;     // bottom edge

  // get distance from closest edges
  float distX = cx-testX;
  float distY = cy-testY;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // if the distance is less than the radius, collision!
  if (distance <= radius) {
    return true;
  }
  return false;
}