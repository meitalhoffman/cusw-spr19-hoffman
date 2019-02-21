/*
class that represents a season for the tree and the corresponding actions
snow effect taken from: http://solemone.de/demos/snow-effect-processing/
*/


class Season {
  String season;
  color backgroundColor;
  String extra;
  
  //info for winter animation
  int quantity = 300;
  float [] xPosition = new float[quantity];
  float [] yPosition = new float[quantity];
  int [] flakeSize = new int[quantity];
  int [] direction = new int[quantity];
  int minFlakeSize = 1;
  int maxFlakeSize = 5;
  
  //info for fall animation
  PImage[] fallImages;
  Leaf[] leafs = new Leaf[50];
  
  Season(String _season) {
    season = _season;
    if (season.equals("winter")){ 
      //season is set to winter
      //set the background color to a blue/grey
      backgroundColor = #a7bac9;
      //set the extra to snow
      extra = "snow";
    }
    else if (season.equals("spring")){
      //season is set to spring
      //set the background color to bright blue
      backgroundColor = #476fef;
      //set the extra to flowers
      extra = "flowers";
    }
    else if (season.equals("summer")){
      //season is set to summer
      //set the background color to bright blue
      backgroundColor = #00e1ff;
      //set the extra to leaves
      extra = "leaves";
    }
    else if (season.equals("fall")){
      //season is set to fall
      //set the background color to a light bright blue
      backgroundColor = #6bc6ff;
      //set the extra to fall leaves
      extra = "fall leaves";
      fallImages = new PImage[3];
      fallImages[0] = loadImage("redleaf.jpg");
      fallImages[1] = loadImage("brownleaf.png");
      fallImages[2] = loadImage("orangeleaf.png");
      
      for (int i = 0; i < 50; i++ ) { 
        float x = 0;
        float y = 20;
        x= random(20, 620);
        leafs[i] = new Leaf (x, y, fallImages[int(random(0, 3))]);
      }
      println("fist element of leaf array: " +leafs[0].toString());
    }
    else {
      //incorrect season initialized, print error statement
      println("ERROR: invalid season");
    }
  }
  
  void addAnimation(){
    if (extra.equals("snow")){
        noStroke();
        smooth();
        for(int i = 0; i < xPosition.length; i++) {
    
    ellipse(xPosition[i], yPosition[i], flakeSize[i], flakeSize[i]);
    
    if(direction[i] == 0) {
      xPosition[i] += map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
    } else {
      xPosition[i] -= map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
    }
    
    yPosition[i] += flakeSize[i] + direction[i]; 
    
    if(xPosition[i] > 640 + flakeSize[i] || xPosition[i] < -flakeSize[i] || yPosition[i] > 360 + flakeSize[i]) {
      xPosition[i] = random(0, 640);
      yPosition[i] = -flakeSize[i];
    }
    
  }
    }
    else if (extra.equals("flowers")){
    }
    else if (extra.equals("leaves")){
    }
    else if (extra.equals("fall leaves")){
      println("adding fall animation");
    for (Leaf l: leafs){
      println(l.toString());
      l.display();
      l.fall();
    }
    }
  }
 
  
}
