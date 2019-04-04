/*
Class to load and process GeoJSON data from Open Street Maps
*/


JSONObject baseMap;
JSONArray features;

float lat_up = 42.33432;
float lat_down = 42.33205;
float lon_left = -71.08125;
float lon_right = -71.07580;


void loadData(){
  //load and resize background choices
 satellite = loadImage("data/satellite.JPG");
 satellite.resize(width, height);
 
 gradient = loadImage("data/gradient.jpg");
 gradient.resize(width, height);
 
 mapBackground = loadImage("data/background1.JPG");
 mapBackground.resize(width, height);
 
 zoomedOut = loadImage("data/zoomedOut.JPG");
 zoomedOut.resize(width, height);
 
 eraser = loadImage("data/eraser.jpg");
 eraser.resize(40, 40);
 
 //get the features
 baseMap = loadJSONObject("data/vacantlotInfo.json");
 features = baseMap.getJSONArray("features");

 }

void parseData(){
  //get the general object
  JSONObject feature = features.getJSONObject(0);
  
  //sort 3 types into our classes to draw
  
  //iterating through the OSM data
  for (int i = 0; i < features.size(); i++){
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    JSONObject properties =  features.getJSONObject(i).getJSONObject("properties");
    
    
  }
}

/*
function that makes point of interests and adds them to the appropriate lists
*/
void makePointofInterest(JSONObject geometry, String _id, String name){
      float lat = geometry.getJSONArray("coordinates").getFloat(1);
      float lon = geometry.getJSONArray("coordinates").getFloat(0);
      POI poi = new POI(lat, lon);
      poi.id = _id;
    
  } 
 
  
  void makPolygon(JSONObject geometry, String name){
      ArrayList<PVector> coords = new ArrayList<PVector>();
      //get the coordinates and iterate through them
      JSONArray coordinates = geometry.getJSONArray("coordinates").getJSONArray(0);
      for(int j = 0; j<coordinates.size(); j++){
        float lat = coordinates.getJSONArray(j).getFloat(1);
        float lon = coordinates.getJSONArray(j).getFloat(0);
        //Make a PVector and add it
        PVector coordinate = new PVector(lat, lon);
        coords.add(coordinate);
      }
      //Create the Polygon with the coordinate PVectors
      Polygon poly = new Polygon(coords, name);
  }
