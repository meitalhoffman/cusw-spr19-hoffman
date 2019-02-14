/*
class defining each node in the network
represents people in our class
*/

class Person {
 
  String name;
  String year;
  PVector screenLocation;
  boolean locked = false; //am I editing my person location

  Person(String _name, String _year) {
    name = _name;
    year = _year;
    screenLocation = new PVector(width/2, height/2, 0);
  }
  
  void randomLocation() {
    screenLocation = new PVector(random(width), random(height));
  }
  
  //see if my mouse cursor is near my person
  boolean hoverEvent(){
    float xDistance = abs(mouseX - screenLocation.x);
    float yDistance = abs(mouseY - screenLocation.y);
    if (xDistance <= 50 && yDistance <= 50){
      return true;
    } else {
      return false;
    }
  }
  
  //is my person selected by the mouse
  boolean checkSelection(){
    if (hoverEvent()){
      locked = true;
    } else {
      locked = false;
    }
    return locked;
  }
  
  //update person loation if locked on
  void update(){
    if (locked) {
      screenLocation = new PVector(mouseX, mouseY);
    }
  }
  
  void drawPerson(){
    noStroke(); //no outline around circle
    if (hoverEvent()){
      fill(#FFFF00);
    } else {
      fill(255); //White fill
    }
    ellipse(this.screenLocation.x, this.screenLocation.y, 100, 100);
    textSize(30);
    text(name + "\nYear: " + year, screenLocation.x + 70, screenLocation.y + 70); 
  }
}
