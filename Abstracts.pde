// DataPoint
abstract class Drawable {
  Drawable() {
  }
  void update() {
  }
  void display() {
  }
}
// DataPoint
interface Interactable {
  boolean isPressed();
  void setOn();
  void setOff();
}

interface Moveable{
 void movePosition(PVector amt);  
}