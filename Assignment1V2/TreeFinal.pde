/*
class that represents an instance of a tree
holds all the different tree images
*/


class Tree {
  //declare variables to keep track of the x,y location of the tree
  int x;
  int y;
  
  PImage fall;
  PImage winter;
  PImage spring;
  PImage summer;
  
  PImage toShow;
    
  Tree(int _x, int _y, Season currentSeason) {
    x = _x;
    y = _y;
    fall = loadImage("treeFall1.jpg");
    winter = loadImage("treeWinter1.jpg");
    spring = loadImage("treeSpring1.jpg");
    summer = loadImage("treeSummer1.jpg");
    
    updateImage(currentSeason);
  }
  
  void loadTree(){
     // Start the tree from the x and y location of your mouse
     image(toShow, x-30, y-30, 60, 60);
     }
     
  void updateImage(Season currentSeason){
    if (currentSeason.season.equals("winter")){
      toShow = winter;
    }
    if (currentSeason.season.equals("spring")){
      toShow = spring;
    }    
    if (currentSeason.season.equals("summer")){
      toShow = summer;
    }    
    if (currentSeason.season.equals("fall")){
      toShow = fall;
    }
  }
  
}
