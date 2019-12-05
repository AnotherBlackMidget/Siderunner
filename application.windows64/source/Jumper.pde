class Jumper extends Enemy
{
  Jumper(PVector p)
  {
    location = p;
    velocity = new PVector (0, 0);
    acceleration = new PVector (0 , 0);
    w = 32;
    h = 32;
    mass = 10;
    jumpCount = 0;
    jumpDebounce = false;
    fillColor = color(0,255,0);
  }

  void update(float deltaTime)
  {
    jump();
    
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0
    
    
    );
    
    location.x-=2;
  }

  void display()
  {
      fill(fillColor);
      stroke(0);
      rect(location.x,location.y,w,h);
  }
  
  void jump()
  {
    if(jumpCount < 2)
    {
      velocity.y = 0;
      acceleration.y = 0;
      PVector force = new PVector (0, -40);
      PVector f = PVector.div (force, mass);
      acceleration.add(f);
      jumpCount++;
    } 
  }
}
