/*
Template for Assignment 2 for 11.S195 Spring 2019 
Created by Nina Lutz, nlutz@mit.edu 
Filled in/modified by Meital Hoffman
2/28/2019

This template is just a suggested structure but feel free to modify it, use code from class, etc
*/

MercatorMap map;
PImage satellite;
PImage mapBackground;



PImage background;

Boolean showAMPM;
Boolean showParks;
Boolean showDrinks;
Boolean showPubs;
Boolean showBars;
Boolean showClubs;
Boolean showBikes;
Boolean streetsOn;

  Button pubButton;
  Button barButton;
  Button clubButton;

void setup(){
  size(1000, 650);
  
  //initialize data structures
  map = new MercatorMap(width, height, 32.0739, 32.0592, 34.7603, 34.7863, 0);
  parks = new ArrayList<Polygon>();
  parkways = new ArrayList<Way>();
  ampms = new ArrayList<POI>();
  clubs = new ArrayList<POI>();
  bars = new ArrayList<POI>();
  pubs = new ArrayList<POI>();
  bikes = new ArrayList<POI>();
  
  buttons = new ArrayList<Button>();
  
  pubButton = new Button(40, 133, "pubs");
  barButton = new Button(140, 133, "bars");
  clubButton = new Button(250, 133, "clubs");
  
  buttons.add(pubButton);
  buttons.add(barButton);
  buttons.add(clubButton);

  
  //set everything to hidden
  showAMPM = false;
  showParks = false;
  showDrinks = false;
  showPubs = true;
  showBars = true;
  showClubs = true;
  showBikes = false;
  streetsOn = false;

  //load and parse data
  loadData();
  parseData();
  
  background = satellite;
}

void draw(){
 //background image from OSM 
  update(mouseX, mouseY);
  image(background, 0, 0);
  fill(0, 120);
  rect(0, 0, width, height);
  
  //Draw all the ways (roads, sidewalks, etc)
  //for(int i = 0; i<ways.size(); i++){
  //  ways.get(i).draw();
  //}
  
  //Draw all parks 
  if(showParks) {
    for(int i = 0; i<parks.size(); i++){
      parks.get(i).draw();
    }
  }

  //Draw all AMPMs
  if(showAMPM){
    for(int i = 0; i<ampms.size(); i++){
      ampms.get(i).draw();
    }
  }
  
  //Draw all clubs
  if(showDrinks){
    if(showBars) {
    for(int i = 0; i<bars.size(); i++){
      bars.get(i).draw();
    }
    }
    if(showPubs){
    for(int i = 0; i<pubs.size(); i++){
      pubs.get(i).draw();
    }
    }
    if(showClubs){
    for(int i = 0; i<clubs.size(); i++){
      clubs.get(i).draw();
    }
    }
  }
  
  if(showBikes){
    for(int i = 0; i<bikes.size(); i++){
      bikes.get(i).draw();
    }
  }
  
  drawInfo();
  }
  
   /*
 function that is called at every key press
 randomly chooses a background color and the corresponding tree/text color
 */
 void keyPressed(){
     if(key == 'a') showAMPM = !showAMPM;
     else if (key == 'p') showParks = !showParks;
     else if (key == 'o') showDrinks = !showDrinks;
     else if (key == 'b') showBikes = !showBikes;
     else if (key == 's'){
       if(streetsOn){
         streetsOn = false;
         background = satellite;
       } else {
         streetsOn = true;
         background = mapBackground;
       }
     }
   }
   
  void update(int x, int y){
    for(Button button: buttons){
      if(overButton(button)){
        button.mousedOver = true;
      } else button.mousedOver = false;
    }
  }
  
  void mousePressed() {
    if(pubButton.mousedOver){
      showPubs = !showPubs;
    }
    if(barButton.mousedOver){
      showBars = !showBars;
    }
    if(clubButton.mousedOver){
      showClubs = !showClubs;
    }
  }
  
  boolean overButton(Button b){
    if (mouseX >= b.x && mouseX <= b.x + b.w && mouseY >= b.y && mouseY <= b.y + b.h) return true;
    else return false;
  }
