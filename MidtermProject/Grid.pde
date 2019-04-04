/*
class that holds a list of blocks and their locations
contains functions to update and display the entire grid
*/
import java.util.Random;

class Grid{
  Random rand;
  
  int startX;
  int startY;
  int h;
  int w;
  int l;
  
  //variable for the scaled height and width of the blocks
  int scaledW;
  int scaledH;
  
  int smallerSide;
  
  int newAgents = 10;
  
  int rows;
  int cols;
  
  color outline = 0;
  color fill = color(255, 0, 0, 100);
  color highlight = color(0, 0, 0);
  
  //2D-array where each entry is a row of blocks
  ArrayList<ArrayList<block>> grid;
  
  //list of the closest selected blocks
  ArrayList<block> closest = null;
  
  //list of the stalls on the grid
  ArrayList<Stall> stalls;
  
  //list of agents on the grid
  ArrayList<agent> agents;
  
  boolean dayOver = false;
  String finaltime;
  
      int maxCount = 0;
    int minCount = 0;
  
  
  //initialize a grid of blocks
  Grid(int _w, int _h, int _l){
    startX = BUFFER;
    startY = BUFFER;
    
    h = _h;
    w = _w;
    l = _l;
    
    grid = getGrid(w, h, l);
    stalls = new ArrayList<Stall>();
    agents = new ArrayList<agent>();
    rand = new Random();
  }
  
  //initialize a grid that has a specific offset
  Grid(int _x, int _y, int _w, int _h, int _l){
    startX = _x;
    startY = _y;
    
    h = _h;
    w = _w;
    l = _l;
    
    grid = getGrid(w, h, l);
    stalls = new ArrayList<Stall>();
    agents = new ArrayList<agent>();
    rand = new Random();
  }
  
  ArrayList<ArrayList<block>> getGrid(int w, int h, int l){
    ArrayList<ArrayList<block>> result = new ArrayList<ArrayList<block>>();
    int num_cols = floor(w/l);
    int num_rows = floor(h/l);
    
    rows = num_rows;
    cols = num_cols;
    
    float widthScaleFactor = (float(4*width)/5.0 - 2*BUFFER)/float(w);
    float heightScaleFactor = (float(height-2*BUFFER))/h;
    
    scaledW = floor(l*widthScaleFactor);
    scaledH = floor(l*heightScaleFactor);
    
    if(scaledW < scaledH) smallerSide = scaledW;
    else smallerSide = scaledH;
    
    int current_x = 0;
    int current_y = 0;
    
    for(int i = 0; i < num_rows; i++){
      ArrayList<block> row = new ArrayList<block>();
      current_x = 0;
      for(int j = 0; j < num_cols; j++){
        row.add(new block(current_x, current_y, smallerSide, smallerSide));
        current_x = current_x + smallerSide;
      }
      result.add(row);
      current_y = current_y + smallerSide;
    }
    return result;
  }
  
  //return the pixel width and height of the graph
  PVector getBounds(){
    return new PVector(cols*smallerSide, rows*smallerSide);
  }
  
  //draw the grid
  void draw(){
    stroke(outline);
    fill(fill);
    pushMatrix();
    translate(startX, startY);
    for(ArrayList<block> row: grid){
      for(block b: row){
        b.draw();
      }
    }
    if(closest != null){
      for(block b: closest){
        noStroke();
        if(placeArt) {
          fill(artStallColor);
          rect(b.x, b.y, smallerSide, smallerSide);
        } else if (placeFood){
          fill(foodStallColor);
          rect(b.x, b.y, smallerSide, smallerSide);
        } 
        }
       if (placePerformance){
          fill(performanceStallColor);
          PVector center = getCenterPoint(closest);
          ellipse(center.x, center.y, smallerSide*2, smallerSide*2);
      } if(erasing){
        fill(255);
        PVector center = getCenterPoint(closest);
        rect(center.x-smallerSide, center.y-smallerSide, smallerSide*2, smallerSide);
      }
    }
    ArrayList<agent> toRemove = new ArrayList<agent>();
    for(agent a: agents){
      a.update();
      if(!a.active) toRemove.add(a);
    }
    agents.removeAll(toRemove);
    for(agent a: agents){
      a.draw();
    }
    for(Stall s: stalls){
      s.draw();
    }
    //draw global timer for the day
    if(stalls.size() == 0) startTime = timer;
    translate(0, smallerSide*rows + 20);
    textSize(18);
    fill(textColor);
    String time = getTime(timer-startTime);
    if(dayOver) time = finaltime;
    text("Time: "+time, 0, 0); 
    text("People: " + str(agents.size()), 0, 24);
    text("Max Footfall: " + str(maxCount), 0, 48);
    popMatrix();
  }
  
  String getTime(int timeMillis){
      timeMillis = timeMillis *5;
      boolean AM = true;
      int startHour = 9;
      int minutes = floor(timeMillis/1000.0);
      int hours = floor(minutes/60.0);
      minutes = minutes - hours*60;
      int finalHour = startHour + hours;
      if(finalHour >= 12) {
        if(finalHour > 12) finalHour-=12;
        AM = false;
      }
      String hoursString;
      String minuteString;
      String time;
      if(str(minutes).length() == 1) minuteString = "0" + str(minutes);
      else minuteString = str(minutes);
      if(str(finalHour).length() == 1) hoursString = "0" + str(finalHour);
      else hoursString = str(finalHour);
      if(AM) time = " AM";
      else time = " PM";
      String finalString = hoursString + ":" + minuteString + time;
      if(finalHour >= 7 && time.equals(" PM")){
        dayOver = true;
      } if(dayOver && agents.size() == 0) finaltime = finalString;
    return finalString;
  }
  
  //get the closest 2x2 of blocks in the grid
  ArrayList<block> closestSelection(int x, int y){
    ArrayList<block> result = new ArrayList<block>();
    block inside = grid.get(0).get(0);
    int row = 0;
    int col = 0;
    Boolean foundBlock = false;
    int adjustedMouseX = x - startX;
    int adjustedMouseY = y - startY;
    for(int i =0; i < rows; i++){
      if(foundBlock) break;
      for(int j=0; j< cols; j++){
        if(foundBlock) break;
        block checking = grid.get(i).get(j);
        if(checking.x <= adjustedMouseX && checking.x + checking.w >= adjustedMouseX &&
           checking.y <= adjustedMouseY && checking.y + checking.h >= adjustedMouseY){
             inside = checking;
             foundBlock = true;
             row = i;
             col = j;
           }
      }
    }
    result.add(inside);
    boolean getLeft = false;
    boolean getRight = false;
    boolean getUp = false;
    boolean getDown = false;
    //check which quadrant of the square the mouse is in, get the neighbors accordind to the quadrant
    // 1 | 2
    // _____
    // 4 | 3
    if(adjustedMouseX <= inside.x + inside.w/2){
      //want the neighbor to the left
      //check that there is a neighbor to the left, if not, get right neighbor
      if(col > 0){
        getLeft = true;
      } else {
        getRight = true;
      }
    } else {
      //want the neighbor to the right
      //check that there is a neighbor to the right
      if(col < cols-1){
        getRight = true;
      } else {
        getLeft = true;
      }
    }
    if(adjustedMouseY <= inside.y +inside.w/2){
      //want the neighbor above the current block
      //check that there is an upstairs neighbor
      if(row > 0){
        getUp = true;
      } else {
        getDown = true;
      }
    } else {
      //want to the neighbor below the current block
      //check that there is a downstair neighbor
      if(row < rows-1){
        getDown = true;
      } else {
        getUp = true;
      }
    }
    if(getUp){
      result.add(grid.get(row-1).get(col));
    } else if (getDown) {
      result.add(grid.get(row+1).get(col));
    }
    if (getLeft){
      result.add(grid.get(row).get(col-1));
    } else if (getRight){
      result.add(grid.get(row).get(col+1));
    }
    //also need to get the diagonal blocks
    if(getLeft && getUp){
      result.add(grid.get(row-1).get(col-1));
    } if(getLeft && getDown){
      result.add(grid.get(row+1).get(col-1));
    } if(getRight && getUp){
      result.add(grid.get(row-1).get(col+1));
    } if(getRight && getDown){
      result.add(grid.get(row+1).get(col+1));
    }
  return result;
  }
  
  //function that gets the center of the four nearest neighbors
  PVector getCenterPoint(ArrayList<block> highlighted){
    PVector result = new PVector();
    //initialize the values to things that will definitely be updated
    int xMax = 0;
    int xMin = width;
    int yMax = 0;
    int yMin = height;
    for(block b: highlighted){
      if(b.x < xMin) xMin = b.x;
      if(b.x + b.w > xMax) xMax = b.x + b.w;
      if(b.y < yMin) yMin = b.y;
      if(b.y + b.h > yMax) yMax = b.y + b.h;
    }
    result.x = (xMax+xMin)/2;
    result.y = (yMax+yMin)/2;
    return result;
  }
  
  void removeStall(ArrayList<block> toCheck){
    ArrayList<Stall> toRemove = new ArrayList<Stall>();
    for(Stall s: stalls){
      for(block b: toCheck){
        if(s.covering.contains(b)) toRemove.add(s);
      }
    }
    stalls.removeAll(toRemove);
    for(agent a: agents){
      a.removedStall();
    }
  }
  
  //function that checks if the blocks are covered or uncovered
  boolean freeSpace(ArrayList<block> toCheck){
    for(block b: toCheck){
      if(b.covered) return false;
    }
    return true;
  }
  
  //function to add a stall, update the agents paths
  void addStall(String type){
    if(stalls.size() == 0) startTime = timer;
    PVector center = getCenterPoint(closest);
    Stall toAdd = new Stall(center, type, this.closest, smallerSide*2.0);
    stalls.add(toAdd);
    for(agent a: agents){
      a.newStall(toAdd);
    }
  }
  
  void addAgentsRandom(int value){
    if(stalls.size() > 0){
      for(int i = 0; i < value; i++){
        int yloc = rand.nextInt(scaledH*smallerSide);
        agent newAgent = new agent(new PVector(0, yloc), this);
        agents.add(newAgent);
        println("added agent!");
      }
    }
  }
  
  //function that returns a random location on an edge of a target stall
  PVector getRandomEdgePoint(Stall end){
     PVector target = new PVector();
    //pick if random spot on left = 0 /right = 1/up = 2/down = 3edge
    int edge = rand.nextInt(4);
    switch (edge){
      case 0:
        //left edge - set x, random y
        target.x = end.location.x;
        target.y = end.location.y + rand.nextInt(smallerSide);
      case 1:
        //right edge - set x, random y
        target.x = end.location.x + smallerSide;
        target.y = end.location.y + rand.nextInt(smallerSide);
      case 2:
        //up edge - random x, set y
        target.x = end.location.x + rand.nextInt(smallerSide);
        target.y = end.location.y;
      case 3:
        //down edge - random x, set y
        target.x = end.location.x + rand.nextInt(smallerSide);
        target.y = end.location.y + smallerSide;
    }
    return target;
  }
  
  //function that returns a random next stall
  Stall getRandomStall(Stall start){
    Stall toGo = start;
    while(toGo == start){
      int nodeIndex = rand.nextInt(stalls.size());
      toGo = stalls.get(nodeIndex);
    }
    return toGo;
  }
  
  //function that returns the closest next stall from a location and a list
  Stall getClosestStallinList(PVector start, ArrayList<Stall> stalls){
    Float minDist = Float.MAX_VALUE;
    Stall minStall = stalls.get(0);
    for(Stall node: stalls) {
      Float dist = node.location.dist(start);
      if(dist < minDist){
        minDist = dist;
        minStall = node;
      }
    }
    return minStall;
  }
  
  //function to update the count of steps on each block tile and update their color values
  void updateStepCount(){
    //iterate through the agents and add one to each block that they are located on
    //up and left edges belong to blocks
    for(agent a: agents){
      block onBlock = getBlock(a.location);
      onBlock.heatVal++;
    }
  }
  
  //helper function that gets the block where the point is located
  block getBlock(PVector loc){
    int row = floor(loc.y/smallerSide);
    int col = floor(loc.x/smallerSide);

    return grid.get(row).get(col);
  }
  
  //function that will update the color values for the blocks on the grid
  void updateColors(){
    //int maxCount = 0;
    //int minCount = 0;
    for(int row = 0; row < rows; row++){
      for(int col = 0; col < cols; col++){
        int count = grid.get(row).get(col).heatVal;
        if(count < minCount) minCount = count;
        if(count > maxCount) maxCount = count;
      }
    }
    for(int row = 0; row < rows; row++){
      for(int col = 0; col < cols; col++){
        block b = grid.get(row).get(col);
        int count = b.heatVal;
        int cVal;
        if(maxCount == 0 && minCount == 0)  cVal = 0;
        else cVal = (count - minCount)*255/(maxCount - minCount);
        b.c = color(255, 255-cVal, 255-cVal, 100);
      }
    }
  }
  
}
