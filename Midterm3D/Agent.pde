/*
class to hold an agent and its properties
*/

class Agent {
  ArrayList<Stall> visited;
  ArrayList<Stall> toVist;
  
  Stall prevStop;
  Stall nextStop;
  
  float timeSpent;
  float timeLimit;
  
  PVector location;
  
  Agent(PVector initialLoc, float _timeLimit){
    location = initialLoc;
    timeLimit = _timeLimit;
    
    
  }
}
