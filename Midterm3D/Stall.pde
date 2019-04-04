/*
class that holds a stall object
stalls can be food vendors or artists
*/

class Stall{
  
  String type;
  PVector location;
  int w = 20;
  int h = 20;
  int diameter = 10;
  color c;
  
  Stall(String _type, PVector _location){
    type = _type;
    location = _location;
    if(type.equals("food")) c = food_color;
    else if(type.equals("art")) c = art_color;
    else if(type.equals("performance")) c = performance_color;
  }
  
  //function that draws each stall in the correct location/orientation on the grid
  void draw(){
        pushMatrix(); translate(location.x, location.y, location.z + 10/2.0);
        fill(c, 200); noStroke();
        box(15, 15, 15);
        popMatrix();
  }
  
  boolean overlapping(PVector loc){
    println("x, y coords of near by chunk: " +str(loc.x) + ", " +str(loc.y));
    println("x, y coords of the stall with edge 15: " + str(location.x) + ", " + str(location.y));
    if (loc.x > location.x && loc.x < location.x + w && loc.y >= location.y && loc.y <= location.y + h) return true;
    else return false;
  }
}
