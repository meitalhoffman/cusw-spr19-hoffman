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

  //Lat, lon values
  float lat;
  float lon;

  //name
  String name;
  
  //id
  String id;

  //String to hold the type -- defaults to empty if there is none
  String type;

  POI(float _lat, float _lon) {
    lat = _lat;
    lon = _lon;
    coord = new PVector(lat, lon);
  }

  void draw() {
    PVector screenLocation = map.getScreenLocation(coord);
    if(id.equals(AMPM))
    {
      image(AMPMpic, screenLocation.x-17, screenLocation.y - 8, 34, 16);
    } if (id.equals("bike")){
      fill(bike_fill);
      rect(screenLocation.x, screenLocation.y, 10, 10);
    }
     if(id.equals(club)){
        fill(fillClub);
        ellipse(screenLocation.x, screenLocation.y, 10, 10);
    } if(id.equals(pub)){
        fill(fillPub);
        ellipse(screenLocation.x, screenLocation.y, 10, 10);
    }if(id.equals(bar)){
        fill(fillBar);
        ellipse(screenLocation.x, screenLocation.y, 10, 10);
    }
  }
}
