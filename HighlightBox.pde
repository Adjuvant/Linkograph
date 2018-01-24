class HighlightBox extends Drawable implements Moveable {
  PVector sp, ep;
  ArrayList<DataPoint> dps;
  boolean moving;
  boolean centered;
  HighlightBox() {
  }

  HighlightBox(PVector mouseIn) {
    sp = new PVector(mouseIn.x, mouseIn.y);
    ep = new PVector(mouseIn.x, mouseIn.y);
    dps = new ArrayList<DataPoint>();
    centered = false; // Important
  }

  void addDataPoint(DataPoint d) {
    if (!dps.contains(d))
      dps.add(d);
  }

  void removeDataPoint(DataPoint d) {
    if (dps.contains(d))
      dps.remove(d);
  }

  void centerMode() {
    centered = true;
    PVector tempCenter = new PVector(getCenterX(), getCenterY());
    PVector tempDim = new PVector(getWidth(), getHeight());
    sp.x = tempCenter.x;
    sp.y = tempCenter.y;
    ep.x = tempDim.x;
    ep.y = tempDim.y;
  }

  void movePosition(PVector amt) {
    moving = true;
    sp.x = amt.x;
    sp.y = amt.y;

    for (Moveable m : dps) {
      m.movePosition(amt);
    }
  }
  float getStartX() {
    if (sp.x>ep.x) {
      return ep.x ;
    } else
      return sp.x ;
  }
  float getStartY() {
    if (sp.y>ep.y) {
      return ep.y ;
    } else
      return sp.y ;
  }
  float getCenterX() {
    if (sp.x>ep.x) {
      return ep.x + (getWidth()/2.0);
    } else
      return sp.x + (getWidth()/2.0);
  }
  float getCenterY() {
    if (sp.y>ep.y) {
      return sp.y - (getHeight()/2.0);
    } else
      return sp.y + (getHeight()/2.0);
  }
  float getWidth() {
    if (sp.x>ep.x) {
      return sp.x - ep.x;
    } else
      return ep.x - sp.x;
  }
  float getHeight() {
    if (sp.y>ep.y) {
      return sp.y - ep.y;
    } else
      return ep.y - sp.y;
  }

  void update(PVector mouseIn) {
    ep.x = mouseIn.x;
    ep.y = mouseIn.y;
  }
  void display() {
    stroke(0, 0, 255);
    if (moving)
      fill(255, 55, 43);
    else
      fill(34, 55, 200);
    if (centered) {
      rectMode(CENTER);
      rect(sp.x, sp.y, ep.x, ep.y);
    } else {
      rectMode(CORNERS);
      rect(sp.x, sp.y, ep.x, ep.y);
      line(getCenterX(), sp.y, getCenterX(), ep.y);
      line(sp.x, getCenterY(), ep.x, getCenterY());
    }
  }
}