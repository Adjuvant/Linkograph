class DataPoint extends Drawable implements Interactable, Moveable {
  DataUnit data;
  PVector p, op, tp; // position and original position and temp position
  float vel = 0.01;
  float velX = 1.0;
  float velY = 1.0;
  float factor = 0.0;
  boolean pressed;
  DataPoint() {
  }

  DataPoint(int in, DataUnit dataIn) {
    pressed = false;
    this.p = generatePoint(in);
    this.op = new PVector(p.x, p.y);
    this.tp = new PVector(p.x, p.y);

    // generateRandomLinks(in);
    this.data = dataIn;
    velX = data.foreLinks.size();
    velY = data.backLinks.size();
  }

  PVector generatePoint(int pNum) {
    PVector tempPoint = new PVector();
    // println("Factor: " + (float)pNum * ( rightAnchor  / (float)numPoints));
    tempPoint.x = leftAnchor + (pNum * distributionFactor);
    tempPoint.y = height - 20;

    return  tempPoint;
  }

  void generateRandomLinks(int in) {
    for (int i = 0; i < numOfItems; i++) {

      if (i!=in) {
        if (random(1.0)>probability) {
          if (!data.foreLinks.contains(i))
            addForeLink(i);
        }

        if (random(1.0)>probability) {
          if (!data.backLinks.contains(i))
            addBackLink(i);
        }
      }
    }
  }

  void addForeLink(int in) {
    data.foreLinks.add(in);
  }

  void addBackLink(int in) {
    data.backLinks.add(in);
  }

  void drawLinks() {

    for (int i = 0; i < data.foreLinks.size(); i++) {
      int n = data.foreLinks.get(i);
      //println(n);
      DataPoint dp = items.get(n);
      PVector p2 = dp.p;
      // PVector p2 = items.get(data.foreLinks.get(i)).p;
      float d = PVector.dist(p, p2);

      stroke(255, 0, 0);
      fill(255, 0, 0);
      line(p.x, p.y, p.x+(d/2.0), p.y-(d/2.0));
      ellipse(p.x+(d/2.0), p.y-(d/2.0), pointSizeHalf, pointSizeHalf);
      line(p.x+(d/2.0), p.y-(d/2.0), p2.x, p2.y);
    }

    for (int i = 0; i < data.backLinks.size(); i++) {
      PVector p2 = items.get(data.backLinks.get(i)).p;
      float d = PVector.dist(p, p2);

      stroke(0, 255, 0);
      fill(0, 255, 0);
      line(p.x, p.y, p.x-(d/2.0), p.y-(d/2.0));
      ellipse(p.x-(d/2.0), p.y-(d/2.0), pointSizeHalf, pointSizeHalf);
      line(p.x-(d/2.0), p.y-(d/2.0), p2.x, p2.y);
    }
  }

  void update() {

    if (!pressed) {
      if (reset) {
        if (p.x!=op.x && p.x!=op.x) { 
          factor+=vel;//(frameCount%frameRate) / frameRate;
          if (factor>1.0) {
            p.x = op.x;
            p.y = op.y;
          } else {
            p.x = easeInOutCubic(factor, tp.x, op.x-tp.x, 1.0);
            p.y = easeInOutCubic(factor, tp.y, op.y-tp.y, 1.0);
          }
        }
      }
      /*
      p.x = p.x + (factor * velX);
       if (p.x>width || p.x < 0.0) {
       velX *= -1.0;
       }
       
       p.y = p.y + (factor * velY);
       if (p.y>height || p.y < 0.0) {
       velY *= -1.0;
       }
       */
    } else {
      p.lerp(mouseX, mouseY, 0.0, 0.9);
      tp.x = mouseX;
      tp.y = mouseY;
    }
  }

  void display() {
    drawLinks();
    stroke(0);
    fill(255);
    ellipseMode(CENTER);
    ellipse(p.x, p.y, pointSize, pointSize);
    textAlign(CENTER, CENTER);
    textSize(6);
    text(data.id, p.x, p.y+10);
    if (pressed) {
      textSize(32);
      text(data.designMove, width/2, height/2);
    }
  }


  /// Interface methods
  // Interactable
  boolean isPressed() {
    return pressed;
  }
  void setOn() {
    factor = 0.0;
    pressed = true;
    println(data.id + " On");
  }
  void setOff() {
    pressed = false;
    println(data.id + " Off");
  }

  // Moveable
  void movePosition(PVector amt) {
    p.x += amt.x;
    p.y += amt.y;
  }
}