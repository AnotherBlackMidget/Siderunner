class Hero extends GraphicObject
{
  int jumpCount;
  boolean jumpDebounce;
  int w, h;
  Animation anim;
  int i;
  float i2;
  Weapon gun;
  
  
  Hero()
  {
    gun = new Weapon("flamethrower");
    anim = new Animation();
    location = new PVector(width/2-8, height - 160);
    velocity = new PVector (0, 0);
    acceleration = new PVector (0 , 0);
    w = 32;
    h = 64;
    mass = 10;
    jumpCount = 0;
    jumpDebounce = false;
    i = 0;
  }

  void update(float deltaTime)
  {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
    
    
    i2 += 0.4;
    if(i2 >= 8)
    {
      i2 = 0;
    }
    i = (int) i2;

  }

  void display()
  {
    
      fill(255,0,0);
      //rect(location.x,location.y,w,h);
      
      if(jumpCount == 0)
      {
        image(anim.sprites[i], location.x-14, location.y);
      }
      else
      {
        image(anim.sprites[8], location.x-14, location.y);
      }
  }
  
  void checkEdges(Tile t) 
  {
    if(t.state == 's')
    {
      if(t.y < location.y+60)
      {
        if(location.x < t.x + 32 && location.x >= t.x + 20)
        {
          location.x = t.x + 32;
        }
        else if(location.x > t.x - w && location.x <= t.x - 4)
        {
          location.x = t.x - w;
        }
      }

      
      if(t.x <= location.x && t.x+32 > location.x)
      {
        if(location.y+h >= t.y && location.y+58< t.y)
        {
          jumpCount = 0; 
          location.y = t.y-h;  
          acceleration = new PVector(0,0);
          velocity = new PVector(0,0);
        }
      }

    }
    
  }
 
  void applyForce (PVector force) 
  {
    PVector f = PVector.div (force, mass);
   
    acceleration.add(f);
  }
  
  void jump()
  {
    if(jumpCount < 2 && !jumpDebounce)
    {
      velocity.y = 0;
      acceleration.y = 0;
      PVector force = new PVector (0, -40);
      PVector f = PVector.div (force, mass);
      acceleration.add(f);
      jumpCount++;
      jumpDebounce = true;
    } 
  }
  
  void fire()
  {
    gun.fire(location);
  }
}