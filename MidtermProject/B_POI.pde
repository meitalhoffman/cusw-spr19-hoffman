/*
class that holds all of our points of interest
this includes transit locations
*/



class POI{
  //What is the coordinate of the POI in lat, lon
  PVector coord;
  //get screen location of poi
  PVector screenLocation;

  //Lat, lon values
  float lat;
  float lon;

  //name
  String name;
  
  //id
  String id;

  //String to hold the type -- defaults to empty if there is none
  String type;
  
  Boolean showName;

  POI(float _lat, float _lon) {
    lat = _lat;
    lon = _lon;
    coord = new PVector(lat, lon);
    showName = false;
    screenLocation = map.getScreenLocation(coord);
  }

  void draw() {
    
  }
  
  /*
  function that draws the name of the location according to where the dot is on the screen
  */
  void drawName(){
    textSize(12);
    fill(255);
    if(showName && !name.equals("")){
      float textWidth = textWidth(name);
      if(screenLocation.x + textWidth > width) text(name, screenLocation.x - textWidth, screenLocation.y+13);
      else text(name, screenLocation.x + 13, screenLocation.y+13);
    } else if (showName && name.equals("")){
      String none = "name unavailable";
      float textWidth = textWidth(none);
      if(screenLocation.x + textWidth > width) text(none, screenLocation.x - textWidth, screenLocation.y+13);
      else text(none, screenLocation.x + 13, screenLocation.y+13);
    }
  }

}
