/* 
Meital Hoffman
2/14/2019
replication of Icebreaker activity
11.S195 Computational Urban Science
Originally created by Ira Winder
*/
//Step 1: allocate memory for your Person
ArrayList<Person> people;
ArrayList<Connection> friends;

//Runs once
void setup(){
  size(1200, 1000); //set canvas size
  initialize();
}

// runs 60 times/second
void draw() {
  background(0); //set background color

  for (Person p: people) {
    p.update();
    p.drawPerson();
  }
  
  for (Connection c: friends) {
    c.draw();
  }
}
  
void mousePressed(){
   for(Person p: people){
     if (p.checkSelection()) {
     break;
     }
   }
 }
 
 void mouseReleased(){
   for(Person p: people){
     p.locked = false;
   }
 }
 
 void keyPressed(){
   initialize();
 }
 
 void initialize(){
   people = new ArrayList<Person>();
  friends = new ArrayList<Connection>();
  
  for( int i =0; i < 25; i++){
    Person p = new Person("Person " + i, str(int(random(1, 5))));
    p.randomLocation();
    people.add(p);
  }
  
  //Who are friends?
  for (Person orgin: people){
    for(Person dest: people) {
      if (!orgin.name.equals(dest.name) && orgin.year.equals(dest.year)){
        friends.add(new Connection(orgin, dest, "friends"));
      }
    }
  }
 }
