//fill color
//color bar_fill = color(255, 229, 10);
color ampm_fill = color(255, 255, 0);
color park_fill = color(0, 77, 0);
color bike_fill = color(102 , 255, 102);

color park_stroke = color(0, 53, 0);

color fillPub = #114C9C;
color fillBar = #4C27A9;
color fillClub = #E51EE9;

int redValue = 255;
int blueValue = 0;
int greenValue = 0;

//color titleColor = color(redValue, greenValue, blueValue);
  
void drawInfo(){
  stroke(0);
  fill(0, 120);
  rect(20, 20, 370, 190);
  textSize(18);
  updateTitle();
  fill(color(redValue, greenValue, blueValue));
  text("A Night Out in Tel Aviv", 100, 40);
  fill(255);
  textSize(16);
  text("Step 1: Find an AM:PM (press a)", 25, 65);
  //fill(bar_fill);
  text("Step 2: Buy drinks and snacks", 25, 85);
  //fill(park_fill);
  text("Step 3: Consume them at a park (press p)", 25, 105);
  text("Step 4: Find somewhere to go out (press o)", 25, 125);
  text("Step 5: Use a bike share to go home (press b)", 25, 180);
  textSize(14);
  text("Hint: Press s to toggle the background", 25, 205);
  text("Made by: Meital Hoffman", 800, 625);
  for(Button b: buttons){
    b.draw();
  }
}
 
  void updateTitle(){
   if( greenValue<255 && redValue==255 && blueValue==0){
     greenValue++;
    }
    
    //go from yellow to pure green
    if(greenValue == 255 && redValue>0){
      //redToGreen = false;
     redValue--; 
    }
    
    //go from green to cyan/bluish-green
    if(redValue==0 && greenValue==255 && blueValue<255){
    
      blueValue++;
    }
    
    //go from bluish-green to blue
    if(blueValue==255 && greenValue>0){
     greenValue--; 
    }
   // go from blue to violet
    if(redValue < 255 && greenValue==0 && blueValue==255){
      redValue++;
      
      }
        //go from violet to red
      if(redValue == 255 && blueValue>0){
        blueValue--;
    }
}
