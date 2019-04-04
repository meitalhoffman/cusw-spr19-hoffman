/*  GUI3D
 *  Ira Winder, ira@mit.edu, 2018
 *
 *  Listen Functions (Superficially Isolated from Main.pde)
 */

// Function that update in-memory elements
//
void listen() {
  
  // screenX() and screenY() methods need 3D camera active
  //
  cam.on();
  
  // Arrow-Object: Calculate Object's Screen Location
  //
  s_x = screenX(objectLocation.x, objectLocation.y, objectLocation.z + 30/2.0);
  s_y = screenY(objectLocation.x, objectLocation.y, objectLocation.z + 30/2.0);
  
  // Click-Object: Draw Selection Cursor
  //
  cursor_x = -1000;
  cursor_y = -1000;
  additionLocation = new PVector(0,0);
  if (cam.enableChunks && cam.chunkField.closestFound && placeAdditions && !cam.hoverGUI()) {
    Chunk c = cam.chunkField.closest;
    additionLocation = c.location;
    // Calculate Cursor Screen Location
    cursor_x = screenX(additionLocation.x, additionLocation.y, additionLocation.z + 30/2.0);
    cursor_y = screenY(additionLocation.x, additionLocation.y, additionLocation.z + 30/2.0);
  }
  
  // Trigger the button
  //
  for(Button b: bar_right.buttons){
    if (b.trigger) {
    println("Button Pressed");
    addition_color = b.col;
    addition_type = b.type;
    b.trigger = false;
  }
  }
}

void mousePressed() { if (initialized) {
  
  cam.pressed();
  //bar_left.pressed();
  bar_right.pressed();
  
} }

void mouseClicked() { if (initialized) {
  
  if (cam.chunkField.closestFound && cam.enableChunks && !cam.hoverGUI()) {
    boolean canAdd = true;
    for(Stall s: additions){
      canAdd = canAdd && !s.overlapping(cam.chunkField.closest.location);
      println("can add updated to: " +str(canAdd));
    }
    if(canAdd) additions.add(new Stall(addition_type, cam.chunkField.closest.location));
  }
  
} }

void mouseReleased() { if (initialized) {
  
  //bar_left.released();
  bar_right.released();
  cam.moved();
  
} }

void mouseMoved() { if (initialized) {
  
  cam.moved();
  
} }

void keyPressed() { if (initialized) {
    
  cam.moved();
  //bar_left.pressed();
  bar_right.pressed();
  
  switch(key) {
    case 'f':
      cam.showFrameRate = !cam.showFrameRate;
      break;
    case 'c':
      cam.reset();
      break;
    case 'r':
      additions.clear();
      //bar_left.restoreDefault();
      bar_right.restoreDefault();
      break;
    case 'h':
      showGUI = !showGUI;
      break;
    case 'p':
      println("cam.offset.x = " + cam.offset.x);
      println("cam.offset.x = " + cam.offset.x);
      println("cam.zoom = "     + cam.zoom);
      println("cam.rotation = " + cam.rotation);
      break;
    case 'a':
      placeAdditions = !placeAdditions;
      break;
    case '-':
      objectLocation.z -= 20;
      break;
    case '+':
      objectLocation.z += 20;
      break;
    case 'b':
      addition_color = art_color;
      addition_type = art;
      break;
    case 'n':
      addition_color = food_color;
      addition_type = food;
      break;
    case 'm':
      addition_color = performance_color;
      addition_type = performance;
      break;
  }
  
  if (key == CODED) {
    if (keyCode == UP) {
      objectLocation.y -= 20;
    } else if (keyCode == DOWN) {
      objectLocation.y += 20;
    } else if (keyCode == LEFT) {
      objectLocation.x -= 20;
    } else if (keyCode == RIGHT) {
      objectLocation.x += 20;
    } 
  }
  
} }

void keyReleased() { if (initialized) {
  bar_right.released();
  
} }
