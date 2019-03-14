/*
class for buttons on the screen
*/
ArrayList<Button> buttons;

class Button {
  int x;
  int y;
  int h = 28;
  int w = 55;
  
  color fill;
  color highlight;

  String text;
  
  boolean mousedOver;
  
  Button(int _x, int _y, String _text){
    x = _x;
    y = _y;
    text = _text;
    if(text.equals("pubs")) {
      fill = fillPub;
      highlight = highlightPub;
      h = 28;
      w = 55;
      
    }
    if(text.equals(" bars")) {
      fill = fillBar;
      highlight = highlightBar;
      h = 28;
      w = 55;
    }
    if(text.equals("clubs")) {
       fill = fillClub;
       highlight = highlightClub;
       h = 28;
        w = 55;
      
    }else if (text.equals("")){
      fill = #7575a3;
      highlight = #b3b3cc;
      h = 20;
      w = 20;
    }
    else if (text.equals("hide")){
      fill = #7575a3;
      highlight = #b3b3cc;
      h = 20;
      w = 20;
    }
  }
  
  /*
  function for drawing the buttons
  */
  void draw() {
    if (mousedOver) fill(highlight);
    else fill(fill, 150);
    stroke(0);
    rect(x, y, w, h);
    fill(255);
    if(text.equals("")){
      line(362, 35, 378, 28); 
      line(362, 35, 378, 43); 

    } else if (text.equals("hide")){
        line(20, 35, 6, 28); 
        line(20, 35, 6, 42); 
    } else text(text, x+10, y+20);

  }
  
}
