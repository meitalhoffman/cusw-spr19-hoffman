/* 
Meital Hoffman
2/14/2019
replication of Icebreaker activity
11.S195 Computational Urban Science
Originally created by Ira Winder
*/
//Step 1: allocate memory for your Person
ArrayList<Person> people;

//Runs once
void setup(){
  size(1200, 1000); //set canvas size
  people = new ArrayList<Person>();
  
  for( int i =0; i < 100; i++){
    Person p = new Person("Person " + i, str(int(random(1, 5))));
    p.randomLocation();
    people.add(p);
  }
}

// runs 60 times/second
void draw() {
  background(0); //set background color
  //fill(255); //define color of the elipse
  //ellipse(mouseX, mouseY, 300, mouseY/10);

  for (Person p: people) {
    p.drawPerson();
  }
}
