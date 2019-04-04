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
PImage zoomedOut;
PImage gradient;

PImage background; //variable to hold current background
PImage eraser;

boolean hideInfo;

//booleans to determine what is visable on the map
Boolean showTransit;
boolean placeArt;
boolean placeFood;
boolean placePerformance;

boolean overGrid;

Button artButton;
Button foodButton;
Button performanceButton;
Button infoIcon;
Button eraserButton;

Button startButton;
Button infoButton;

int timer;
int startTime = 0;
int intervalCount = 1000;
int intervalColor = 5000;

//grid for placing items that includes list of stalls
Grid grid;

boolean startScreen;
boolean information;
boolean editing;
boolean drawInstructions;

boolean erasing;

float scale = 1.001;

/*
function that is called once when the program is executed
*/
void setup(){
  //set the screen size
  size(1400, 800);
  init();
  startScreen = true;
}

/*
function called every frame, updates the view according to user input
*/
void draw(){
  if(startScreen) {
    image(loading, 0, 0);
    startButton.draw();
    checkStart(mouseX, mouseY);
  } else if(information) {
    image(zoomedOut, 0, 0);
    drawInstructions();
    infoButton.draw();
    checkInfo(mouseX, mouseY);
  }
  else {
    timer = millis();
    //update where the mouse position is.
    update(mouseX, mouseY);
    
    //draw the background image
    if(!editing){
      image(background, 0, 0);
      //put a transparent grey layer over it to make it more dull
      fill(0, 120);
      rect(0, 0, width, height);
    } else {
      image(gradient, 0, 0);
      //put a transparent grey layer over it to make it more dull
      fill(0, 120);
      rect(0, 0, width, height);
      //add agents if they're all gone or every three seconds
      if(grid.agents.size() == 0 && !grid.dayOver) grid.addAgentsRandom(10);
      else if(timer%5000 < 50 && !grid.dayOver) grid.addAgentsRandom(5);
      if(timer%intervalCount < 100) grid.updateStepCount();
      if(timer%intervalColor < 100) grid.updateColors();
      
      grid.draw();
    }
    
    //if info is hidden, draw it to the side, otherwise draw all of the information
    if(hideInfo) hiddenInfo();
    else drawInfo();
    if(drawInstructions) drawInstructionsSmall();
    
    }
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
    if(infoIcon.mousedOver) drawInstructions = true;
    else drawInstructions = false;
    //check the showed info button seperately, since it is not in the buttons list
    //showInfoButton.mousedOver = overButton(showInfoButton);
    //check if the mouse is in the grid area, and if so, update the closest selected blocks
    overGrid = overGrid(x, y, grid);
    if(overGrid){
      grid.closest = grid.closestSelection(mouseX, mouseY);
    } else {
      grid.closest = null;
    }
  }
  
  /*
  function called to check where the mouse is and to shade items accordingly
  */
  void checkStart(int x, int y){
    if(overButton(startButton)){
        startButton.mousedOver = true;
      } else startButton.mousedOver = false;
    }
  /*
  function called to check where the mouse is and to shade items accordingly
  */
  void checkInfo(int x, int y){
    if(overButton(infoButton)){
        infoButton.mousedOver = true;
      } else infoButton.mousedOver = false;
    }
    
  /*
  function called when the mouse is pressed
  */
  void mousePressed() {
    if(startButton.mousedOver){
      startScreen = false;
      information = true;
    }
    if(eraserButton.mousedOver){
      erasing = true;
      placeArt = false;
      placeFood = false;
      placePerformance = false;
      
    }
    if(infoButton.mousedOver){
      information = false;
      editing = true;
    }
    if(artButton.mousedOver){
      placeArt = !placeArt;
      placeFood = false;
      placePerformance = false;
      erasing = false;
    }
    if(foodButton.mousedOver){
      placeFood = !placeFood;
      placeArt = false;
      placePerformance = false;
      erasing = false;
    }
    if(performanceButton.mousedOver){
      placePerformance = !placePerformance;
      placeArt = false;
      placeFood = false;
      erasing = false;
    }
    //add new Art Stall
    if(overGrid && placeArt){
      if(grid.freeSpace(grid.closest)){
        grid.addStall("Art");
      }
    }
    //add new food stall
    else if(overGrid && placeFood){
      if(grid.freeSpace(grid.closest)){
        grid.addStall("Food");
      }
    }
    //add new performance stall
    else if(overGrid && placePerformance){
      if(grid.freeSpace(grid.closest)){
        grid.addStall("Performance");
      }
    }
    //erase item
    else if(overGrid && erasing){
      grid.removeStall(grid.closest);
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
  
  /*
  function that checks whether the mouse is over the grid
  */
  boolean overGrid(int x, int y, Grid g){
    if(mouseX >= g.startX && mouseX <= g.startX + g.smallerSide*g.cols + g.smallerSide && mouseY >= g.startY && mouseY <= g.startY + g.smallerSide*g.rows + g.smallerSide) return true;
    else return false;
  }
