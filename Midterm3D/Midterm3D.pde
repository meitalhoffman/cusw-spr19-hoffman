/* 
 *  Edited by Meital Hoffman
 *  For 11.S195 Computation Urban Science Workshop Spring 2019
 *  Midterm Presentation
 *  Artist Market in South Boston
 *  
 *  GUI3D ALGORITHMS
 *  Ira Winder, ira@mit.edu, 2018
 *
 *  These script demonstrates the implementation of a Camera() and Toolbar() 
 *  classes that has ready-made UI, Sliders, Radio Buttons, I/O, and smooth camera 
 *  transitions. For a generic implementation check out the repo at: 
 *  http://github.com/irawinder/GUI3D
 *
 *  CLASSES CONTAINED:
 *
 *    Camera()     - The primary container for implementing and editing Camera parameters
 *    HScollbar()  - A horizontal Slider bar
 *    VScrollBar() - A Vertical Slider Bar
 *    XYDrag()     - A Container for implmenting click-and-drag 3D Navigation
 *    Chunk()      - A known, fixed volume of space
 *    ChunkGrid()  - A grid of Chunks in 3D space that are accessible via the mouse cursor
 *
 *    Toolbar()       - Toolbar that may implement ControlSlider(), Radio Button(), and TriSlider()
 *    ControlSlider() - A customizable horizontal slider ideal for generic parameritization of integers
 *    Button()        - A customizable button that triggers a one-time action
 *    RadioButton()   - A customizable radio button ideal for generic parameritization of boolean
 *    TriSlider()     - A customizable triangle slider that outputs three positive floats that add up to 1.0
 */

public void settings() {
  size(1280, 800, P3D);
  //fullScreen(P3D);
}

// Runs once when application begins
//
void setup() {
  
}

// Runs on a infinite loop after setup
//
void draw() {
  if (!initialized) {
    
    // A_Init.pde - runs until initialized = true
    // Unlike setup(), allows display of animated loading screen
    //
    init();
    
  } else {
    
    // A_Listen.pde - Updates settings and values for this frame
    //
    if (showGUI) listen();
    
    // A_Render.pde - Renders current frame of visualization
    //
    background(0);
    render3D();
    if (showGUI) render2D();
  }
}
