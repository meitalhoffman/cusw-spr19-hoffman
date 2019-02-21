 /*
Meital Hoffman
Created 2/14/2019, completed 2/21/2019
Assignment 1 for 11.S195
Take 3: FINAL Version
growing recursive tree trees
Inspired by/recursion code from: https://processing.org/examples/tree.html
*/

float           theta;                  //recursive branch angle
float           h                = 120; //set branching height to 120
boolean         newTree;                //boolean whether to start a new tree
int             interval         = 500; //milliseconds interval before the next recursive branching
Tree            currentTree;            //current tree to branch
ArrayList<Tree> trees;                  //active trees
boolean         first;                  //whether this is the first tree to appear or not
color           backgroundColor;        //current background Color
color           currentTreeColor;       // current tree color - depends on background color
color[]         colors;                 //all background colors
color[]         treeColor;              //corresponding tree colors (black or white)
int             timer;                  //timer to be updated each draw() call
int             counter          = 0;   //to keep up with the timer and use for branching timing


void setup() {
  size(640, 360); //set the window size to 640 pixels x 360 pixels 
  colors           = new color[] {#f442e2, #ea3115, #2da512, #38ead2, #0d5de8, #782aed, #cc97ef, #578456, #062e38, #b6d3db};//initialize all of the background color options
  treeColor        = new color[] {0, 255, 255, 0, 255, 255, 0, 255, 255, 0};                                                //set all of the corresponding tree colors
  trees            = new ArrayList<Tree>();        //initialize the new tree arraylist
  backgroundColor  = colors[0];                    //set the initial background color to pink
  currentTreeColor = treeColor[0];                 //set the initial tree color to black
  newTree          = false;                        //newTree is false to begin since first is true  
  first            = true;
  theta            = radians(random(40, 90));      //select a random angle(within reason) to have the first tree branch at
  Tree tree        = new Tree(width/2, 240, theta);//initialize a new tree in the middle of the screen with the random branch angle
  currentTree      = tree;                         //set the current tree to the new tree just created
  trees.add(tree);                                 //add the new tree to the tree array
  textSize(12);                                    //set the text size to 12 pixels
}

void draw() {
    pushMatrix();                     //save the current transformation state
    timer = millis();                 //set the timer to the millisecond runtime clock of the program
    background(backgroundColor);      //set the background color to the current background color
    stroke(currentTreeColor);         //set the stroke color to the current tree color
    strokeWeight(3);                  //set the stroke to 3 pixels
    if (first){                       //check if this is the first tree to be made
      counter = timer + interval;     //if it is, set the counter to the timer + interval so the tree will begin to branch
      first   = false;                //set first to false, the first tree has been created
    }
    if (trees.size() > 10){           //check if there are more than 10 trees on the screen, if so, clear and start over
      trees   = new ArrayList<Tree>();//initialize a new tree list
      newTree = true;                 //set newTree to true, we need to create a new tree wherever the mouse is
    }
    if (newTree){                                 //if we need to create a new tree
      Tree tree   = new Tree(mouseX, 240, theta); //create a new tree at the current x location of the mouse and at the bottom of the screen with branch angle theta
      trees.add(tree);                            //add the new tree to the trees list
      currentTree = tree;                         //set the current tree to the new one that was just created
      newTree     = false;                        //we don't need a new tree anymore
    }
    for (Tree t: trees){
      pushMatrix();                               //save the current transformation state
      t.startTree();                              
      t.branch(t.h, t.level);
      popMatrix();                                //reset the transformation state
    }
    if (getDiffRange(timer, counter) && currentTree != null && !currentTree.branchingDone){ //check if the counter is in the interval range and the tree can continue to branch
      currentTree.incrementLevel();
      counter+=interval;
    }
    if(currentTree.branchingDone){ //if the tree is done branching, make a new one!
      float a = (mouseX / (float) width) * 90f;
      theta   = radians(a);
      counter+=interval;
      newTree = true;
    }
    popMatrix();                                                        //restore transformation state
    fill(currentTreeColor);                                             //set text color to tree color
    text(" Branching Angle: " +str(int(degrees(theta))) + "°", 500, 25);//update the displayed angle
    text("Number of New Branches: 2^" +str(currentTree.level), 450, 45);//update the displayed branch level
}

/* 
function that is called at every mouse click
updates the branching angle theta according to the mouse's x location on the screen
newTree required and sets the interval forward so the new tree branches at creation
*/
void mousePressed(){
    float a = (mouseX / (float) width) * 90f;
    theta   = radians(a);
    counter = timer + interval;
    newTree = true;
 }
 /*
 function that is called at every key press
 randomly chooses a background color and the corresponding tree/text color
 */
 void keyPressed(){
     int index        = int(random(10));
     backgroundColor  = colors[index];
     currentTreeColor = treeColor[index];
   }

/*
function that takes in the current timer and count variables
checks whether they are within the set interval and returns that boolean
used to check whether to continue branching
*/
boolean getDiffRange(int timer, int count){
  if (abs(count - timer) < interval){
    return true;
  } else {
    return false;
  }
}  
