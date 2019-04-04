//fill color

/*
function that draws the information box
it will take up a third of the screen on the right
*/

//buffer value for any information or items on the screen
int BUFFER = 50;

int startInfoX;

//color values
color artStallColor = color(231, 179, 81);
color foodStallColor = color(225, 79, 90);
color performanceStallColor = color(50, 144, 134);

color artStallHighlight = color(211, 152, 43);
color foodStallHighlight = color(205, 42, 54);
color performanceStallHighlight = color(133, 203, 196);

color agentColor = color(231, 145, 81);
color textColor = color(255);

String title = "Proposed Artist Market In South Boston: Site Exploration";

void drawInfo(){
  textAlign(LEFT);
  noStroke();
  fill(0, 100);
  rect(startInfoX, 0, width/4, height);
  fill(255);
  textSize(25);
  text("Toolbar", startInfoX+20, 50);
  textSize(20);
  text("Add Items", startInfoX +20, 150);
  textSize(35);
  text(title, grid.startX, grid.startY/2+30);
  for(Button b: buttons){
    b.draw();
  }
}

void drawInstructionsSmall(){
  noStroke();
  fill(0, 50);
  rect(BUFFER*2+50, BUFFER*2+10, 800, 400);
  textAlign(CENTER);
  String text0 = "Use this interactive tool to design a new artist market in South Boston.";
  String text1 = "Click on the icons to add artist stalls, food stands, and performance podiums.";
  String text2 = "Click on the eraser tool to remove stalls.";
  String text3 = "Use the magnifying glass to inspect the footfall of each 5x5 meter sqaure.";
  fill(255);
  textSize(25);
  text(text0, 180, 150, 700, height);
  text(text1, 180, 225, 700, height);
  text(text2, 180, 310, 700, height);
  text(text3, 180, 360, 700, height);
  textAlign(LEFT);
}

void drawInstructions(){
  noStroke();
  fill(0, 100);
  rect(15, 15, width-30, height-30);
  textAlign(CENTER);
  String text0 = "Use this interactive tool to design a new artist market in South Boston. Add and remove artist stalls, food stands, and performance podiums.";
  String text1 = "Watch responsive agents move through the space. Inspect the footfall of each 5x5 meter sqaure.";
  String text2 = "The site is two adjacent parking lots with good transit accessibility. The space's dimensions are 420 meters by 222 meters.";
  fill(255);
  textSize(30);
  text(title, width/2, 50);
  textSize(25);
  text(text0, width/2-350, 100, 700, height);
  text(text1, width/2-350, 250, 700, height);
  text(text2, width/2-350, 350, 700, height);
  pushMatrix();
  translate(width/2+105, height - 100);
  stroke(color(255, 255, 0));
  strokeWeight(2);
  fill(color(255, 255, 0, 100));
  rotate(PI/4);
  rect(0, 0, 15, 25);
  fill(255);
  rotate(-PI/4);
  noStroke();
  textSize(20);
  text("Site", 40, 0);
  popMatrix();  
}
void hiddenInfo(){
  stroke(0);
  fill(0, 120);
  rect(0, 20, 25, 208);
  //showInfoButton.draw();
  fill(255);
  textSize(14);
  text("Made by: Meital Hoffman", 800, 625);
}
