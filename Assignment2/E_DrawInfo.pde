//fill color
//color bar_fill = color(255, 229, 10);
color ampm_fill = color(255, 255, 0);
color park_fill = color(0, 77, 0);
color bike_fill = color(102 , 255, 102);

color fillPub = #114C9C;
color fillBar = #4C27A9;
color fillClub = #E51EE9;
  
void drawInfo(){
  fill(0, 120);
  rect(20, 20, 370, 190);
  textSize(18);
  fill(255);
  text("A Night Out in Tel Aviv", 25, 40);
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
