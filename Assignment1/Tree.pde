/*
class that represents an instance of the recursive tree
*/


class Tree {
  //declate a variable to keep track of the level of the tree
  int level;
  //declare variables to keep track of the start x,y location of the tree
  int x;
  int y;
  //declare a variable for the initial branch height. Constant for now but may implement feature to allow for user input
  float h = 120;
  
  boolean branchingDone = false;
  
  Tree(int _x, int _y) {
    level = 0;
    x = _x;
    y = _y;
  }
  
  void incrementLevel(){
    level++;
  }
  
  void startTree(){
     // Start the tree from the x and y location of your mouse
     translate(x,y);
     // Draw a line 120 pixels
     line(0,0,0,h);
     // Move to the end of that line
     //translate(0,-120);
     }
  
  void branch(float h, int _level) {
    if (_level > 0) {
      
        // Each branch will be 2/3rds the size of the previous one
        h *= 0.66;
  
      // All recursive functions must have an exit condition!!!!
      // Here, ours is when the length of the branch is 2 pixels or less
      if (h > 2) {
        _level = _level -1; //decrement the level of the tree
        pushMatrix();    // Save the current state of transformation (i.e. where are we now)
        rotate(theta);   // Rotate by theta
        line(0, 0, 0, -h);  // Draw the branch
        translate(0, -h); // Move to the end of the branch
        branch(h, _level);       // Ok, now call myself to draw two new branches!!
        popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
        
        // Repeat the same thing, only branch off to the "left" this time!
        pushMatrix();
        rotate(-theta);
        line(0, 0, 0, -h);
        translate(0, -h);
        branch(h, _level);
        popMatrix();
      } else {
        branchingDone = true;
      }
    }
  }
}
