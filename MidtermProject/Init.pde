/*
file to hold all of the initialization functions
*/
PImage loading;

void init(){
  int phase = 0;
  loading = loadImage("data/loadingScreen.jpg");
  loading.resize(width, height);
  drawLoading(phase);

  //initialize data structures
  map = new MercatorMap(width, height, 32.0739, 32.0592, 34.7603, 34.7863, 0);
  polygons = new ArrayList<Polygon>();
  buttons = new ArrayList<Button>();
  transit = new ArrayList<POI>();
    
  startInfoX = 4*(width/5);

  artButton = new Button(startInfoX+ 20, 170, "Art");
  foodButton = new Button(startInfoX+ 20, 245, "Food");
  performanceButton = new Button(startInfoX+ 20, 320, "Performance");
  startButton = new Button(width/2-65, 170, "Start");
  infoButton = new Button(width/2-100, 500, "Go");
  infoIcon = new Button(startInfoX + 20, 70, "Info Icon");
  eraserButton = new Button(startInfoX + 20, 390, "Erase");

  buttons.add(artButton);
  buttons.add(foodButton);
  buttons.add(performanceButton);
  buttons.add(infoIcon);
  buttons.add(eraserButton);
  
  phase = 1;
  drawLoading(phase);
  //start by showing info
  hideInfo = false;
  
  //start by not placing any new items
  placeArt = false;
  placeFood = false;
  placePerformance = false;
  
  overGrid = false;
  
  information = false;
  editing = true;
  erasing = false;
  
  //load and parse data
  loadData();
  parseData();
  phase = 2;
  drawLoading(phase);
  //start with the background set to the satellite image
  background = satellite;
    
  //initialize the grid for placing items
  grid = new Grid(BUFFER, BUFFER*2, 420, 222, 5);
  phase = 3;
  drawLoading(phase);
}

void drawLoading(int phase){
  image(loading, 0, 0);
  //drawSection0(true);
  //switch(phase){
  //  case 0:
  //    drawSection1(false);
  //    drawSection2(false);
  //    drawSection3(false);
  //  case 1:
  //    drawSection1(true);
  //    drawSection2(false);
  //    drawSection3(false);
  //  case 2:
  //    drawSection1(true);
  //    drawSection2(true);
  //    drawSection3(false);
  //  case 3:
  //    drawSection1(true);
  //    drawSection2(true);
  //    drawSection3(false);
  //}
}

void drawSection0(boolean filled){
  if(filled) fill(255);
  else fill(0);
  rect(width/2-100, height/2, 30, 15);
}
void drawSection1(boolean filled){
  if(filled) fill(255);
  else fill(0);
  rect(width/2-70, height/2, 80, 15);
}
void drawSection2(boolean filled){
  if(filled) fill(255);
  else fill(0);
  rect(width/2+10, height/2, 60, 15);
}
void drawSection3(boolean filled){
  if(filled) fill(255);
  else fill(0);
  rect(width/2+70, height/2, 30, 15);
}
