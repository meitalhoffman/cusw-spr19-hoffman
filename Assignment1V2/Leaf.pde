//class to hold the information for falling leaves
// leaf falling animation taken from https://www.openprocessing.org/sketch/118960/
class Leaf{
  float xpos;
  float ypos;
  float yspeed;
  float xspeed;
  float rot;
  PImage turnedLeaf;
  

  Leaf (float xIn, float yIn, PImage choose) {
    xpos = xIn;
    ypos = yIn;
    turnedLeaf = choose;
    yspeed = random(1, 4);
    xspeed = 2*cos(xIn);
    rot = 0;
  }


  void display () {
    print("trying to display");
    pushMatrix();
    translate(xpos, ypos);
    rotate(rot);
    image(turnedLeaf, 0, 0, 20, 20);
    popMatrix();
  }

  void fall () { 
    ypos = ypos + yspeed;
    xpos = xpos + xspeed;
    if (ypos > height-20) {
      yspeed = 0;
      xspeed = 0;
    }
    if (ypos < height-20) {
      rot = random(0, PI);
    }
  }
  
  String toString(){
    return "I am a leaf at position: " + str(xpos) + ", " + (str(ypos));
  }
}
