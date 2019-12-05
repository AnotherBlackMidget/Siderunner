class Runner extends Enemy
{  
  Runner(PVector p)
  {
    location = p;
    velocity = new PVector (0, 0);
    acceleration = new PVector (0 , 0);
    w = 32;
    h = 64;
    mass = 10;
    fillColor = color(255,0,0);
  }

  void update(float deltaTime)
  {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
    location.x-=4;
  }


  void display()
  {
      fill(fillColor);
      stroke(0);
      rect(location.x,location.y,w,h);
  }
}
