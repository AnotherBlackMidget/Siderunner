abstract class Enemy extends GraphicObject
{
  int health;
  int damage;
  int jumpCount;
  boolean jumpDebounce;
  int w, h;
  boolean loaded = false;
  
  void checkEdges(Tile t) 
  {
    if(t.state == 's')
    {
      if(t.y < location.y+h-4)
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
        if(location.y+h >= t.y && location.y+h-6< t.y)
        {
          jumpCount = 0; 
          location.y = t.y-h;  
          acceleration = new PVector(0,0);
          velocity = new PVector(0,0);
        }
      }
    } 
  }
  
  boolean checkHero(Hero hero)
  {
    
    if( (hero.location.x+hero.w > location.x && hero.location.x < location.x + w) && (hero.location.y+hero.h > location.y && hero.location.y < location.y + h) )
    {
      //fillColor = color(255,0,0);
      return true;
    }
    else
    {
      return false;
    }
  }
  
  
  void applyForce (PVector force) 
  {
    PVector f = PVector.div (force, mass);
   
    acceleration.add(f);
  }
}
