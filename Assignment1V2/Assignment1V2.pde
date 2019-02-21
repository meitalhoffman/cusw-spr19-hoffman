/*
Meital Hoffman
Created 2/14/2019
Assignment 1 for 11.S195 version 2
using tree images instead of tree recursion
Button code taken from: https://processing.org/examples/button.html
*/

//declare an array of trees to keep track of
ArrayList<Tree> trees;

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
String buttonText = "Erase";
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
  strokeWeight(3);
  
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
    drawButton();
    for (Tree t: trees){
      t.loadTree();
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
      return;
    }
    Tree newTree = new Tree(mouseX, mouseY, currentSeason);
    newTree.loadTree();
    trees.add(newTree);

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
   for (Tree t: trees){
     t.updateImage(currentSeason);
   }
 }
