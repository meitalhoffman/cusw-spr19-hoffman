/*
class for picking which kinds of places to go out
*/
ArrayList<Button> buttons;

class Button {
  
  int x;
  int y;
  int h = 28;
  int w = 55;
  
  color fillPub = #114C9C;
  color fillBar = #4C27A9;
  color fillClub = #E51EE9;
  color highlightPub = #062044;
  color highlightBar = #311872;
  color highlightClub = #7d107f;
  
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
      
    }
        if(text.equals("bars")) {
      fill = fillBar;
      highlight = highlightBar;
    }
        if(text.equals("clubs")) {
       fill = fillClub;
       highlight = highlightClub;
      
    }
  }
  
  void draw() {
    if (mousedOver) fill(highlight);
    else fill(fill, 150);
    stroke(0);
    rect(x, y, w, h);
    fill(255);
    text(text, x+10, y+20);
  }
  
}
