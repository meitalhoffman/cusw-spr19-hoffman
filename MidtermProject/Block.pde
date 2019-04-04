/*
class that holds a block object that is the basis for the grid
*/
class block {
  int x;
  int y;
  int w;
  int h;
  
  int heatVal;
  color c;
  color outline = color(0, 20);
  
  boolean covered;
  
  ArrayList<block> neighbors;
  
  block(int _x, int _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    covered = false;
    c = color(255, 100);
  }
  
  void draw(){
    fill(c);
    stroke(outline);
    rect(x, y, w, h);
  }
  
}
