/*
class that represents a season for the tree and the corresponding actions
snow effect taken from: http://solemone.de/demos/snow-effect-processing/
*/


class Season {
  String season;
  color treeColor;
  color backgroundColor;
  String extra;
  
  int quantity = 300;
  float [] xPosition = new float[quantity];
  float [] yPosition = new float[quantity];
  int [] flakeSize = new int[quantity];
  int [] direction = new int[quantity];
  int minFlakeSize = 1;
  int maxFlakeSize = 5;
  
  Season(String _season) {
    season = _season;
    if (season.equals("winter")){ 
      //season is set to winter
      //set the tree color to a dark brown color
      treeColor = #280202;
      //set the background color to a blue/grey
      backgroundColor = #a7bac9;
      //set the extra to snow
      extra = "snow";
    }
    else if (season.equals("spring")){
      //season is set to spring
      //set the tree color to a light brown color
      treeColor = #603131;
      //set the background color to bright blue
      backgroundColor = #476fef;
      //set the extra to flowers
      extra = "flowers";
    }
    else if (season.equals("summer")){
      //season is set to summer
      //set the tree color to a light brown color
      treeColor = #603131;
      //set the background color to bright blue
      backgroundColor = #00e1ff;
      //set the extra to leaves
      extra = "leaves";
    }
    else if (season.equals("fall")){
      //season is set to fall
      //set the tree color to a darker brown color
      treeColor = #4c2727;
      //set the background color to a light bright blue
      backgroundColor = #6bc6ff;
      //set the extra to fall leaves
      extra = "fall leaves";
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
    }
  }
 
  
}
