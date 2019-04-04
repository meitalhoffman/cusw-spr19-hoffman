/*
class to hold the agents who are wandering around the park
*/

class agent {
  Grid grid;
  PVector location;
  PVector target;
  ArrayList<Stall> toVisit;
  int timeUntilFood;
  boolean leaving;
  boolean active;
  ArrayList<Float> delta;
  
  color c;
  
  Float v = 1.;
  
  agent(PVector _location, Grid _grid){
    location = _location;
    grid = _grid;
    c = agentColor;
    leaving = false;
    active = true;
    toVisit = new ArrayList<Stall>(grid.stalls);
    //start by going to a random stall in the list
    if(toVisit.size() > 0){
      println("picking a random stall to visit");
      int index = int(random(toVisit.size()));
      Stall nextStall = toVisit.get(index);
      target = grid.getRandomEdgePoint(nextStall);
      delta = getXYDelta(location, target, v);
      toVisit.remove(nextStall);
    }  
  }
  
  void newStall(Stall add){
    toVisit.add(add);
    if(leaving){
      leaving = false;
      Stall nextStall = grid.getClosestStallinList(location, toVisit);
      target = grid.getRandomEdgePoint(nextStall);
      delta = getXYDelta(location, target, v);
      toVisit.remove(nextStall);
    }
  }
  
  void update(){
    //got to location
    if(abs(location.x - target.x) < 2 && abs(location.y - target.y) < 2){
      if(leaving){
        active = false;
      }
      else if(readyToLeave()){
        leave();
        leaving = true;
      } else {
        Stall nextStall = grid.getClosestStallinList(location, toVisit);
        target = grid.getRandomEdgePoint(nextStall);
        delta = getXYDelta(location, target, v);
        toVisit.remove(nextStall);
      }
      
    }
    location.x = location.x + delta.get(0);
    location.y = location.y + delta.get(1);
  }
  
  void removedStall(){
     if(readyToLeave()){
        leave();
        leaving = true;
      } else {
        Stall nextStall = grid.getClosestStallinList(location, toVisit);
        target = grid.getRandomEdgePoint(nextStall);
        delta = getXYDelta(location, target, v);
        toVisit.remove(nextStall);
      }
      update();
  }
  //function that draws an agent
  void draw(){
    fill(c);
    ellipse(location.x, location.y, 8, 8);
    //println("drawing the agent");
    //println("location x is: " +str(location.x));
    //println("location y is: " + str(location.y));
  }
  
  //function that returns the change in X and Y per frame for the agent
  ArrayList<Float> getXYDelta(PVector start, PVector target, Float velocity){
    ArrayList<Float> result = new ArrayList<Float>();
    Float xdist = target.x - start.x;
    Float ydist = target.y - start.y;
    Float angle = atan2(ydist, xdist);
    Float deltaX = cos(angle)*(velocity);
    Float deltaY = sin(angle)*(velocity);
    result.add(deltaX);
    result.add(deltaY);
    return result;
  }
  
  boolean readyToLeave(){
    return toVisit.size() == 0;
  }
  
  void leave(){
    //find the closest edge
    PVector up = new PVector(location.x, 0);
    PVector down = new PVector(location.x, grid.rows*grid.smallerSide);
    PVector left = new PVector(0, location.y);
    PVector right = new PVector(grid.cols*grid.smallerSide, location.y);
    ArrayList<PVector> sides = new ArrayList<PVector>();
    sides.add(up);
    sides.add(down);
    sides.add(left);
    sides.add(right);
    PVector min = location;
    Float minDist = Float.MAX_VALUE;
    for(int i = 0; i < sides.size(); i++){
      if(location.dist(sides.get(i)) < minDist){
        minDist = location.dist(sides.get(i));
        min = sides.get(i);
      }
    }
    target = min;
    delta = getXYDelta(location, min, v);
    println("Leaving the grid");
  }
  
}
