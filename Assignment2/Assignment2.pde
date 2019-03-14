/*
Template for Assignment 2 for 11.S195 Computation Science Workshop MIT Spring 2019 
Created by Nina Lutz, nlutz@mit.edu 
Filled in/modified by Meital Hoffman meital@mit.edu
2/28/2019

A Night Out in Tel Aviv
*/

MercatorMap map;

PImage satellite; //satellite background image
PImage mapBackground; //map background image

PImage background; //variable to hold current background

boolean hideInfo;

//booleans to determine what is visable on the map
Boolean showAMPM;
Boolean showParks;
Boolean showDrinks;
Boolean showPubs;
Boolean showBars;
Boolean showClubs;
Boolean showBikes;
Boolean streetsOn;

//initialize buttons for the different kinds of places to go out
Button pubButton;
Button barButton;
Button clubButton;

Button hideInfoButton;
Button showInfoButton;

/*
function that is called once when the program is executed
*/
void setup(){
  //set the screen size
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
  
  //initialize buttons
  pubButton = new Button(40, 133, "pubs");
  barButton = new Button(140, 133, " bars");
  clubButton = new Button(250, 133, "clubs");
  hideInfoButton = new Button(360, 25, "");
  showInfoButton = new Button(2, 25, "hide");

  //add buttons to list
  buttons.add(pubButton);
  buttons.add(barButton);
  buttons.add(clubButton);
  buttons.add(hideInfoButton);
  
  //set everything to hidden, but bars, clubs, and pubs are true so they all show when drinks are turned on
  showAMPM = false;
  showParks = false;
  showDrinks = false;
  showPubs = true;
  showBars = true;
  showClubs = true;
  showBikes = false;
  streetsOn = false;
  
  //start by showing info
  hideInfo = false;

  //load and parse data
  loadData();
  parseData();
  
  //start with the background set to the satellite image
  background = satellite;
}

/*
function called every frame, updates the view according to user input
*/
void draw(){
  //update where the mouse position is
  update(mouseX, mouseY);
  
  //draw the background image
  image(background, 0, 0);
  //put a transparent grey layer over it to make it more dull
  fill(0, 120);
  rect(0, 0, width, height);
  
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
    //first draw the points
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
    //now draw the names, so they aren't hidden by the points
    if(showBars) {
    for(int i = 0; i<bars.size(); i++){
      bars.get(i).drawName();
    }
    }
    if(showPubs){
    for(int i = 0; i<pubs.size(); i++){
      pubs.get(i).drawName();
    }
    }
    if(showClubs){
    for(int i = 0; i<clubs.size(); i++){
      clubs.get(i).drawName();
    }
    }
    
  }
  
  //draw all of the bike share locations
  if(showBikes){
    for(int i = 0; i<bikes.size(); i++){
      bikes.get(i).draw();
    }
  }
  
  //if info is hidden, draw it to the side, otherwise draw all of the information
  if(hideInfo) hiddenInfo();
  else drawInfo();
  }
  
   /*
 function that is called at every key press
 check the input key and adjust the boolenas accordingly to show the correct item
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
   
  /*
  function called to check where the mouse is and to shade items accordingly
  */
  void update(int x, int y){
    for(Button button: buttons){
      if(overButton(button)){
        button.mousedOver = true;
      } else button.mousedOver = false;
    }
    //check the showed info button seperately, since it is not in the buttons list
    showInfoButton.mousedOver = overButton(showInfoButton);
    //go through the outing locations and check if they are moused over/name should show
    for(POI pub: pubs){
      pub.showName = overPOI(pub);
    }
    for(POI club: clubs){
      club.showName = overPOI(club);
    }
    for(POI bar: bars){
      bar.showName = overPOI(bar);
    }
  }
  /*
  function called when the mouse is pressed
  */
  void mousePressed() {
    if(pubButton.mousedOver){
      if(showDrinks) showPubs = !showPubs;
    }
    if(barButton.mousedOver){
      if (showDrinks) showBars = !showBars;
    }
    if(clubButton.mousedOver){
      if(showDrinks) showClubs = !showClubs;
    }
    if (hideInfoButton.mousedOver){
      hideInfo = true;
    }
    if (showInfoButton.mousedOver){
      hideInfo = false;
    }
  }
  
  /*
  function that checks whether the mouse is over a button
  */
  boolean overButton(Button b){
    if (mouseX >= b.x && mouseX <= b.x + b.w && mouseY >= b.y && mouseY <= b.y + b.h) return true;
    else return false;
  }
  
  /*
  fuction that checks whether the mouse is over one of the point of interests
  */
  boolean overPOI(POI p){
    float disX = p.screenLocation.x - mouseX;
    float disY = p.screenLocation.y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < 13/2 ) {
      return true;
    } else {
      return false;
    }
  }
