/*
class defining each node in the network
represents people in our class
*/

class Person {
 
  String name;
  String year;
  PVector screenLocation;

  Person(String _name, String _year) {
    name = _name;
    year = _year;
    screenLocation = new PVector(width/2, height/2, 0);
  }
  
  void randomLocation() {
    screenLocation = new PVector(random(width), random(height));
  }
  
  void drawPerson(){
    noStroke(); //no outline around circle
    fill(255); //White fill
    ellipse(this.screenLocation.x, this.screenLocation.y, 100, 100);
    textSize(30);
    text(name + "\nYear: " + year, screenLocation.x + 70, screenLocation.y + 70); 
  }
}
