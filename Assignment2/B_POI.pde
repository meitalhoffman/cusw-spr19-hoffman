/*
class that holds all of our points of interest
this includes the AM:PMs and the nightclubs
*/

ArrayList<POI> ampms;
ArrayList<POI> clubs;
ArrayList<POI> bars;
ArrayList<POI> pubs;
ArrayList<POI> bikes;


PImage AMPMpic;

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
    if(id.equals(AMPM))
    {
      image(AMPMpic, screenLocation.x-17, screenLocation.y - 8, 34, 16);
    } if (id.equals("bike")){
      drawBike(int(screenLocation.x), int(screenLocation.y));
    }
     if(id.equals(club)){
        if(showName) fill(highlightClub);
        else fill(fillClub);
        ellipse(screenLocation.x, screenLocation.y, 13, 13);
    } if(id.equals(pub)){
        if(showName) fill(highlightPub);
        else fill(fillPub);
        ellipse(screenLocation.x, screenLocation.y, 13, 13);
    }if(id.equals(bar)){
        if(showName) fill(highlightBar);
        else fill(fillBar);
        ellipse(screenLocation.x, screenLocation.y, 13, 13);
    }if(showName && !name.equals("")){
      textSize(12);
      fill(255);
      text(name, screenLocation.x + 13, screenLocation.y+13);
    }
  }
  
  //function taken from Amy Vogel
  void drawBike(int xLoc, int yLoc) {
     // draw a bike
     float u = 2; // make a simple unit to use for drawing
     stroke(bike_fill);
     noFill();
     strokeWeight(u/2);
     circle(xLoc-5*u, yLoc+2*u, u*5); // wheel 1
     circle(xLoc+5*u, yLoc+2*u, u*5); // wheel 2
     // bars of the bike
     line(xLoc-5*u, yLoc+2*u, xLoc, yLoc+2*u); 
     line(xLoc-5*u, yLoc+2*u, xLoc-2*u, yLoc-3*u); 
     line(xLoc-2*u, yLoc-3*u, xLoc+4*u, yLoc-3*u); 
     line(xLoc+5*u, yLoc+2*u, xLoc+4*u, yLoc-3*u); 
     line(xLoc, yLoc+2*u, xLoc+4.3*u, yLoc-2*u); 
     line(xLoc-2*u, yLoc-5*u, xLoc, yLoc+2*u);
     // handle bars
     strokeWeight(u/3);
     line(xLoc+4*u, yLoc-3*u, xLoc+4*u, yLoc-5*u);
     line(xLoc+4*u, yLoc-5*u, xLoc+5*u, yLoc-6*u);
     line(xLoc+5*u, yLoc-6*u, xLoc+4.5*u, yLoc-6.5*u);
     line(xLoc+4.5*u, yLoc-6.5*u, xLoc+2.5*u, yLoc-6.5*u);
     noStroke();
  }

}
