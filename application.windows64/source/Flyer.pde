class Flyer extends Enemy
{  
  Flyer(PVector p)
  {
    location = p;
  
    w = 32;
    h = 16;
    fillColor = color(0,0,255);
  }
  
  void update(float deltaTime)
  {
    location.x-=6;
  }
  
  void display()
  {
    fill(fillColor);
    stroke(0);
    rect(location.x,location.y,w,h);
  }
  
  void checkEdges(Tile t) 
  {
    
  }  
  
  void applyForce (PVector force) 
  {
    
  }
}
