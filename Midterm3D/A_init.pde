/*  GUI3D
 *  Ira Winder, ira@mit.edu, 2018
 *
 *  Init Functions (Superficially Isolated from Main.pde)
 */

// Camera Object with built-in GUI for navigation and selection
//
Camera cam;
PVector B; // Bounding Box for 3D Environment
int MARGIN; // Pixel margin allowed around edge of screen

// Semi-transparent Toolbar for information and sliders
//
//Toolbar bar_left, bar_right; 
Toolbar bar_right;
int BAR_X, BAR_Y, BAR_W, BAR_H;
boolean showGUI;

// Location of an Object a user can move with arrow keys
//
PVector objectLocation; 
float s_x, s_y;

// Locations of objects user has placed with mouse
//
ArrayList<Stall> additions; 
boolean placeAdditions;
float cursor_x, cursor_y;
PVector additionLocation;

//Pathfinder and agent object initialization
//
ArrayList<Agent> agents;
Pathfinder findPath;

// Processing Font Containers
PFont f12, f18, f24;

// Counter to track which phase of initialization
//
boolean initialized;
int initPhase = 0;
int phaseDelay = 0;
String status[] = {
  "Initializing Canvas ...",
  "Loading Data ...",
  "Initializing Toolbars and 3D Environment ...",
  "Ready to go!"
};
int NUM_PHASES = status.length;

void init() {
  
  initialized = false;
    
  if (initPhase == 0) {
    
    // Load default background image
    //
    loadingBG = loadImage("data/loadingScreen.jpg");
    
    // Set Fonts
    //
    f12 = createFont("Calibri", 12);
    f18 = createFont("Calibri", 18);
    f24 = createFont("Calibri", 24);
    textFont(f12);
    
    // Create canvas for drawing everything to earth surface
    //
    B = new PVector(420, 220, 0);
    MARGIN = 10;
    
  } else if (initPhase == 1) {
    
    // Init Data / Sample 3D objects to manipulate
    //
    objectLocation = new PVector(B.x/2, B.y/2, 0);
    additions = new ArrayList<Stall>();
    placeAdditions = true;
    
  } else if (initPhase == 2) {
    
    // Initialize GUI3D
    //
    showGUI = true;
    initToolbars();
    initCamera();
    
  } else if (initPhase == 3) {
    
    initialized = true;
  }
  
  loadingScreen(loadingBG, initPhase, NUM_PHASES, status[initPhase]);
  if (!initialized) initPhase++; 
  delay(phaseDelay);

}

void initCamera() {
  
  // Initialize 3D World Camera Defaults
  //
  cam = new Camera (B, MARGIN);
  cam.ZOOM_DEFAULT = 0.4;
  cam.ZOOM_POW     = 1.75;
  cam.ZOOM_MAX     = 0.25;
  cam.ZOOM_MIN     = 0.75;
  cam.ROTATION_DEFAULT = PI; // (0 - 2*PI)
  cam.init(); // Must End with init() if any BASIC variables within Camera() are changed from default
  
  // Add non-camera UI blockers and edit camera UI characteristics AFTER cam.init()
  //
  cam.vs.xpos = width - 3*MARGIN - BAR_W;
  //cam.hs.enable = false; //disable rotation
  cam.drag.addBlocker(width - MARGIN - BAR_W, MARGIN, BAR_W, BAR_H);
  
  // Turn cam off while still initializing
  //
  cam.off();  
}

void initToolbars() {
  
  // Initialize Toolbar
  BAR_X = MARGIN;
  BAR_Y = MARGIN;
  BAR_W = 250;
  BAR_H = 800 - 2*MARGIN;
  
  // Right Toolbar
  bar_right = new Toolbar(width - (BAR_X + BAR_W), BAR_Y, BAR_W, BAR_H, MARGIN);
  bar_right.title = "";
  bar_right.credit = "Toolbar\n\n";
  bar_right.explanation = "Framework for explorable 3D model parameterized with sliders, radio buttons, and 3D Cursor. ";
  bar_right.explanation += "\n\nPress ' r ' to reset all inputs\nPress ' p ' to print camera settings\nPress ' a ' to add add objects\nPress ' h ' to hide GUI";

  //add slider for actor additions
  bar_right.addSlider("SPACER",   "kg", 50, 100, 72, 1, '<', '>', false);
  bar_right.addSlider("New People per Second", "", 0, 50, 5, 1, '<', '>', false);
  
  //add buttons for different additions
  bar_right.addButton("New Artist Stall", art, art_color, 'b', true);
  bar_right.addButton("New Food Stall", food, food_color, 'n', true);
  bar_right.addButton("New Artist Stall", performance, performance_color, 'm', true);

  //remove spacer slider
  bar_right.sliders.remove(0);
}

//initialize the pathfinder and agents
void initPathandAgents(){
  findPath = new Pathfinder();
  
  //initialize 16 agents, 4 at each corner
  
}

// Converts latitude, longitude to local friendly screen units (2D or 3D)
PVector latlonToXY(PVector latlon, float latMin, float latMax, float lonMin, float lonMax, float xMin, float yMin, float xMax, float yMax) {
  float X_Width = xMax - xMin;
  float Y_Width = yMax - yMin;
  float lat_scaler = (latlon.x - latMin) / abs(latMax - latMin);
  float lon_scaler = (latlon.y - lonMin) / abs(lonMax - lonMin);
  float X  = xMin + X_Width * lon_scaler;
  float Y  = yMin - Y_Width * lat_scaler + Y_Width;
  return new PVector(X,Y);
}
