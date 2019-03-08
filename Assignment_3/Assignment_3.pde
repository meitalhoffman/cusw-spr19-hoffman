/*
tabs taken from Nina Lutz
modified by Meital Goffman for 11.S195 3/7/2019
*/

MercatorMap map;
Raster raster;

void setup(){
  CensusPolygons = new ArrayList<Polygon>();
  size(600, 600);
  //initialize data structure early in setup
  map = new MercatorMap(width, height, 42.25, 41.85, -87.89, -87.5, 0);
  loadData();
  parseData();
  raster = new Raster(20, 600, 600);
  //println(correlationTest());
}

void draw(){
  background(0);
  for(int i = 0; i<CensusPolygons.size(); i++){
      CensusPolygons.get(i).draw();
  }
  drawInfo();
  //raster.draw();
  //county.draw();
}

//draw the key of what you're seeing
void drawInfo(){
  stroke(0);
  fill(0);
  rect(400, 20, 180, 120);
  textSize(18);
  fill(255);
  text("Chicago", 405, 45);
  textSize(15);
  text("Colored according to", 405, 65);
  text("percent of mixed", 406, 80);
  text("race population", 406, 95);
  text("white           --> black", 405, 115);
  textSize(15);
  text(str(max) + "% --> " + str(min) + "%", 405, 130);
}
