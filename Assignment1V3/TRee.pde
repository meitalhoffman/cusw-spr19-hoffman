/*
class that represents an instance of the recursive tree
*/


class Tree {
  int level;                    //keeps track of the level of the tree
  int x;                        //keep track of the start x,y location of the tree
  int y;
  float h               = 120;  //initial branch height. Constant for now but may implement feature to allow for user input
  float angle;                  //branching angle
  boolean branchingDone = false;//true iff the tree has finished branching, ie the branch height <2 pixels, usually at level 10
  
  /*
  function that creates a new instance of the TRee class
  takes in an x,y location and a branhcing angle
  starts the level of the tree at 0
  */
  Tree(int _x, int _y, float _angle) {
    level = 0;
    x     = _x;
    y     = _y;
    angle = _angle;
  }
  
  /*
  function that increments the level of the tree
  used so that the greater program is not direcly accessing the object fields
  */
  void incrementLevel(){
    level++;
  }
  
  /*
  function to start the branching of the tree
  draws the initial line to the bottom of the screen
  */
  void startTree(){
     translate(x,y);  //move to the trees x,y location
     line(0,0,0,h);   // Draw a 120 pixel line 120 to the bottom of the sceen
     branch(h, level);//let the tree branch
     }
  
  /*
  recursive function that rotates and transformation to the left and right and draws a line 2/3 of the last one
  function taken (almost identically) from https://processing.org/examples/tree.html
  added the level check and field
  */
  void branch(float h, int _level) {
    if (_level > 0) {
      h *= 0.66; // Each branch will be 2/3rds the size of the previous one
  
      // All recursive functions must have an exit condition!!!!
      // Here, ours is when the length of the branch is 2 pixels or less
    if (h > 2) {
      _level = _level -1; //decrement the level of the tree
      pushMatrix();       // Save the current state of transformation (i.e. where are we now)
      rotate(angle);      // Rotate by theta
      line(0, 0, 0, -h);  // Draw the branch
      translate(0, -h);   // Move to the end of the branch
      branch(h, _level);  // Ok, now call myself to draw two new branches!!
      popMatrix();        // Whenever we get back here, we "pop" in order to restore the previous matrix state
      
      // Repeat the same thing, only branch off to the "left" this time!
      pushMatrix();
      rotate(-angle);
      line(0, 0, 0, -h);
      translate(0, -h);
      branch(h, _level);
      popMatrix();
    } else {
      branchingDone = true;//if the height is less than 2 pixels, this tree is done branching!
      }
    }
  }
}
