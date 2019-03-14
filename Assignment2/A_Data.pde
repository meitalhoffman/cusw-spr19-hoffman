/*
Class to load and process GeoJSON data from Open Street Maps
*/


JSONObject TelAviv;
JSONArray features;

//hardcoded bike share locations
float bikeInfo[][] = {{32.0627738, 34.7797898},
 {32.0652262, 34.7765779},
 {32.0597378, 34.7616984},
 {32.0621553, 34.7646086},
 {32.0639488, 34.7618701},
 {32.0635067, 34.7731689},
 {32.0667298, 34.7714858},
 {32.0674594, 34.779799},
 {32.0684152, 34.7782959},
 {32.069463, 34.7836643},
 {32.0702165, 34.7847238},
 {32.0694528, 34.7706731},
 {32.0722666, 34.773834},
 {32.0748565, 34.781886},
 {32.0739531, 34.7651947}};

float lat_up = 32.0739;
float lat_down = 32.0592;
float lon_left = 34.7603;
float lon_right = 34.7863;

String AMPM = "AM:PM";
String club = "club";
String nightclub = "nightclub";
String bar = "bar";
String pub = "pub";
String garden = "garden";
String park = "park";

void loadData(){
  //load and resize background
 satellite = loadImage("data/background1.JPG");
 satellite.resize(width, height);
 
 mapBackground = loadImage("data/background.JPG");
 mapBackground.resize(width, height);
 
 //load the AMPM logo
 AMPMpic = loadImage("data/ampm.JPG");
 //get the features
 TelAviv = loadJSONObject("data/osmData.json");
 features = TelAviv.getJSONArray("features");

 }

void parseData(){
  //get the general object
  JSONObject feature = features.getJSONObject(0);
  
  //sort 3 types into our classes to draw
  //AMPMs -> properties.tags.name = "AM:PM"
  //nightclubs, club, bar, pub -> amenity = ["club", "nightclub", "bar", "pub"]
  //Parks -> leisure = ["garden", park"]
  //iterating through the OSM data
  for (int i = 0; i < features.size(); i++){
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    JSONObject properties =  features.getJSONObject(i).getJSONObject("properties");
    
    String amenity = properties.getJSONObject("tags").getString("amenity");
    String leisure = properties.getJSONObject("tags").getString("leisure");
    String englishName = properties.getJSONObject("tags").getString("name:en");
    String name = "";
    //set the name of a location to the English name, if available
    if(englishName == null) name = properties.getJSONObject("tags").getString("name");
    else name = englishName;
    
    if(amenity == null) amenity = "";
    if(leisure == null) leisure = "";
    if(name == null) name = "";
    
    //check if its an AMPM
    if(name.equals(AMPM)){
      makePointofInterest(geometry, name, "");
    } //otherwise, check if it's a place to go out
    else if (amenity.equals(bar) || amenity.equals(club) || amenity.equals(nightclub) || amenity.equals(pub)){
      makePointofInterest(geometry, amenity, name);
    } //otherwise check if its a park or a garden
    else if (leisure.equals(park) || leisure.equals(garden)){
        //only include polygons
        if(type.equals("Polygon")){
          makeParkPolygon(geometry, name);
      }
  }
  }
  //iterate through Tel Ofen Bike share locations and make the bike
    for (int i = 0; i < bikeInfo.length; i++){
      float lat = bikeInfo[i][0];
      float lon = bikeInfo[i][1];
      makeBike(lat, lon);
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
      if(_id.equals(AMPM)) {
        poi.name = AMPM;
        ampms.add(poi);
      }
      else if(_id.equals(club) || _id.equals(nightclub)){
        poi.name = name;
        poi.id = club;
        clubs.add(poi);
      }
      else if(_id.equals(bar)){
        poi.name = name;
        bars.add(poi);
      }
      else if(_id.equals(pub)){
        poi.name = name;
        pubs.add(poi);
      }
  } 
  
  void makeBike(float lat, float lon){
      POI poi = new POI(lat, lon);
      poi.id = "bike";
      bikes.add(poi);
  }
  
  void makeParkPolygon(JSONObject geometry, String name){
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
      parks.add(poly);
  }
