/*
Template for Assignment 2 for 11.S195 Computation Science Workshop MIT Spring 2019 
Created by Nina Lutz, nlutz@mit.edu 
Filled in/modified by Meital Hoffman meital@mit.edu
3/13/2019

Designing an Artist Market in South Boston
*/

MercatorMap map;

PImage satellite; //satellite background image
PImage mapBackground; //map background image

PImage background; //variable to hold current background

boolean hideInfo;

//booleans to determine what is visable on the map
Boolean showTransit;

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
  polygons = new ArrayList<Polygon>();
  buttons = new ArrayList<Button>();
  
  hideInfoButton = new Button(360, 25, "");
  showInfoButton = new Button(2, 25, "hide");

  buttons.add(hideInfoButton);

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
  
  //if info is hidden, draw it to the side, otherwise draw all of the information
  if(hideInfo) hiddenInfo();
  else drawInfo();
  }
  
   /*
 function that is called at every key press
 check the input key and adjust the boolenas accordingly to show the correct item
 */
 void keyPressed(){

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
  }
  /*
  function called when the mouse is pressed
  */
  void mousePressed() {
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
