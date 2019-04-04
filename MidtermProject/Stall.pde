/*
class to hold the stall type
holds information for the performance stalls, art stalls, and food stalls
*/

class Stall {
  ArrayList<block> covering;
  ArrayList<block> surrounding;
    
  String type;
  
  color c;
  
  PVector location;
  Float l;
  
  Stall(PVector center, String _type, ArrayList<block> _covering, Float length){
    location = center;
    type = _type;
    covering = _covering;
    //set all of the blocks to be covered
    for(block b: covering){
      b.covered = true;
    }
    
    if(type.equals("Art")) c = artStallColor;
    else if(type.equals("Food")) c = foodStallColor;
    else c = performanceStallColor;
    l = length;
  }
  
  //function to draw the stall
  void draw(){
    noStroke();
    fill(c);
    if(type.equals("Performance")){
      ellipse(location.x, location.y, l, l);
    }
    else {
      rect(location.x-l/2, location.y-l/2, l, l);
    }
  }
}
