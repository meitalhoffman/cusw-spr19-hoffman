/*
class for buttons on the screen
*/
ArrayList<Button> buttons;

class Button {
  int x;
  int y;
  int r = 40;
  
  int w;
  int h;
  
  color fill;
  color highlight;

  String type;
  String text;
  
  boolean mousedOver;
  
  Button(int _x, int _y, String _type){
    x = _x;
    y = _y;
    type = _type;
    if (type.equals("Art")){
      fill = artStallColor;
      highlight = artStallHighlight;
      text = "Artist Stall";
      w = r;
      h = r;
    }
    else if(type.equals("Food")){
      fill = foodStallColor;
      highlight = foodStallHighlight;
      text = "Food Stand";
      w = r;
      h = r;
    }
    else if (type.equals("Performance")){
      fill = performanceStallColor;
      highlight = performanceStallHighlight;
      text = "Performance Podium";
      w = r;
      h = r;
    } else if (type.equals("Start")){
      fill = 255;
      highlight = color(200);
      text = "Click to Start";
      w = 195;
      h = 50;
    } else if (type.equals("Go")){
      fill = 255;
      highlight = color(200);
      text = "Let's Get Started";
      w = 195;
      h = 50;
    }
    else if (type.equals("Info Icon")){
      fill = 0;
      highlight = color(200);
      text = "i";
      w = r;
      h = r;
    }
    else if (type.equals("Erase")){
      fill = 255;
      highlight = color(200);
      text = "Remove Items";
      w = r;
      h = r-20;
    }
  }
  
  /*
  function for drawing the buttons
  */
  void draw() {
    strokeWeight(1);
    if (mousedOver) fill(highlight);
    else fill(fill, 150);
    stroke(0);
    textSize(20);
    if(type.equals("Start")){
      textSize(20);
      rect(x, y, 195, 50);
      fill(0);
      text(text, x+33, y+30);
      return;
    }
    if(type.equals("Go")){
      noStroke();
      textSize(20);
      rect(x, y, 195, 50);
      fill(0);
      text(text, x+95, y+30);
      return;
    }
    if(type.equals("Info Icon")){
      noStroke();
      textSize(30);
      rect(x, y, r, r);
      fill(255);
      text(text, x+15, y+30);
      textSize(20);
      text("Information", x+r+10, y+25);
      return;
    }
    if(type.equals("Erase")){
      stroke(200);
      rect(x, y, w, h);
      textSize(20);
      fill(255);
      text(text, x+50, y+15);
      return;
    }
    if(type.equals("Art") | type.equals("Food")) rect(x, y, r, r);
    else if(type.equals("Performance")) ellipse(x+r/2, y+r/2, r, r);
    fill(255);
    text(text, x+r+10, y+25);
  }
  
}
