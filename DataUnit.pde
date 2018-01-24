class DataUnit {

  int id;
  String designMove;
  ArrayList<Integer> foreLinks = new ArrayList<Integer>();
  ArrayList<Integer> backLinks = new ArrayList<Integer>();

  DataUnit() {
  }

  DataUnit(int id, String s, int[] fl, int[] bl) {
    this.id = id;
    this.designMove = s;
    if (fl != null) {
      for (int i = 0; i<fl.length; i++) {
        foreLinks.add(fl[i]);
      }
    }
    if (bl != null) {
      for (int i = 0; i<bl.length; i++) {
        backLinks.add(bl[i]);
      }
    }
  }
  /*
  DataUnit(int id, String s, int[] fl, int[] bl) {
    this.id = id;
    this.designMove = s;
    if (fl != null && fl.length>1) {
      for (int i = 0; i<fl.length; i++) {
        foreLinks.add(fl[i]);
      }
    }
    if (bl != null && bl.length>1) {
      for (int i = 0; i<bl.length; i++) {
        backLinks.add(bl[i]);
      }
    }
  }
  */
}