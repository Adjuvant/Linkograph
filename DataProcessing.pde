ArrayList<DataUnit> parseData() {  //<>// //<>// //<>//
  String[] lines = loadStrings("protocol.csv");

  String[] piece = split(lines[0], ',');
  String[][] table = new String[lines.length-1][piece.length];

  for (int i = 1; i < lines.length; i++) {
    table[i-1] = split(lines[i], ',');
  }

  ArrayList<DataUnit> data = new ArrayList<DataUnit>();

  for (int i = 0; i < table.length; i++) {
    int[] fl;
    int[] bl;
    String[] forelinks;
    String[] backlinks;
    forelinks = split(table[i][2], " ");
    backlinks = split(table[i][3], " ");

    if (!forelinks[0].equals("")) {
      fl = new int[forelinks.length];
      for (int n = 0; n<forelinks.length; n++) {
        fl[n] = Integer.parseInt(forelinks[n]) - 1;
      }
    } else fl = null;

    if (!backlinks[0].equals("")) {
      bl = new int[backlinks.length];
      for (int n = 0; n<backlinks.length; n++) {
        bl[n] = Integer.parseInt(backlinks[n]) - 1;
      }
    } else bl = null;

    data.add(new DataUnit(
      Integer.valueOf(table[i][0]), 
      table[i][1], 
      fl, bl));
  }

  // println(table[10][3]);
  /*
  int i = 0;
   for(DataUnit d : data){
   println("i: " + i );
   println("ID: " + d.id );
   println("FL: " + d.foreLinks);
   println("BL: " + d.backLinks);
   i++;
   }
   */
  return data;
}