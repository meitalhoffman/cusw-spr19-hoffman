/*
Meital Hoffman
Created 2/14/2019
Assignment 1 for 11.S195
growing tree
Inspired by/recursion code from: https://processing.org/examples/tree.html
Button code taken from: https://processing.org/examples/button.html
*/

//set the recursive branch angle
float theta = .45;
//initialize the branching height to 120
float h = 120;
//initialize the recursive level to 1
int level = 0;
//set a boolean whether to start a new tree
boolean newTree;
//declare a variable for current x and y coords of the current tree
int x;
int y;
//declare an array of trees to keep track of
ArrayList<Tree> trees;
//declare the current tree to branch
Tree currentTree;
//declare all of the season options
Season winter;
Season spring;
Season summer;
Season fall;
//declare a variable to hold the current season
Season currentSeason;

//New Tree button set up
//x, y coordinates of button
int buttonX, buttonY;
//diameter of button
int rectSize = 90;
//text of button
String buttonText = "Clear";
//color for button and button highlight
color rectColor, rectHighlight;
//boolean to check if curser is over button
boolean rectOver;

boolean clearClicked;

//int currentX;
//int currentY;

void setup() {
  size(640, 360);
  //initialize the trees array
  trees = new ArrayList<Tree>();
  
  //initialize all of the season options
  winter = new Season("winter");
  spring = new Season("spring");
  summer = new Season("summer");
  fall = new Season("fall");
  currentSeason = spring;
  background(currentSeason.backgroundColor);
  stroke(currentSeason.treeColor);
  strokeWeight(3);
  newTree = false;
  clearClicked = false;
  //initialize the button colors
  rectColor = color(0); //black
  rectHighlight = color(51); //grey
  buttonX = 530;
  buttonY = 20;
  ellipseMode(CENTER);
  
  for(int i = 0; i < winter.quantity; i++) {
    winter.flakeSize[i] = round(random(winter.minFlakeSize, winter.maxFlakeSize));
    winter.xPosition[i] = random(0, width);
    winter.yPosition[i] = random(0, height);
    winter.direction[i] = round(random(0, 1));
  }

}

void draw() {
    background(currentSeason.backgroundColor);
    stroke(currentSeason.treeColor);
    drawButton();
    if (newTree){
      Tree tree = new Tree(mouseX, 240);
      currentTree = tree;
      tree.startTree();
      newTree = false;
    }
    else if (currentTree != null){
      currentTree.startTree();
      currentTree.branch(currentTree.h, currentTree.level);
    }
    currentSeason.addAnimation();

  //currentX = mouseX;
  //currentY = mouseY;
  //background(currentSeason.backgroundColor);
  //text("current mouse location is: " +str(currentX) + ", " + str(currentY), 50, 50);

}

void drawButton(){
  update(mouseX, mouseY);
  if (rectOver) {
    fill(rectHighlight); 
  } else {
    fill(rectColor);
  }
  strokeWeight(1);
  stroke(255);
  rect(buttonX, buttonY, rectSize, rectSize/2);
  
  fill(255);
  text(buttonText, 550, 45);
}

void update(int x, int y){
  if (overRect(buttonX, buttonY, rectSize, rectSize/2)){
    rectOver = true;
  } else {
    rectOver = false;
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
  mouseY >= y && mouseY <= y+height){
    return true;
  } else {
    return false;
  }
}

void mousePressed(){
    println("mouse is pressed");
    if(rectOver) {
      clearClicked = true;
      currentTree = null;
      return;
    }
    if (currentTree == null){
      newTree = true;
      return;
    }
    currentTree.incrementLevel();
    newTree = currentTree.branchingDone;

 }
 
 void keyPressed(){
   if (key == 's'){
     currentSeason = summer;
   } else if (key == 'f'){
     currentSeason = fall;
   } else if (key == 'w') {
     currentSeason = winter;
   } else if (key == 'p') {
     currentSeason = spring;
   } else //pick a random season 
     {
       Season[] seasons = {spring, summer, winter, fall};
       int index = int(random(4));
       currentSeason = seasons[index];
   }
 }
