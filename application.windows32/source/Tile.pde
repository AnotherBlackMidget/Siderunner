class Tile extends GraphicObject
{
  color tileColor;
  int type;
  int x;
  int y;
  char state;
  PImage tileImage;
  
  Tile(color tc, int i, int j, char s, PImage im)
  {
    tileColor = tc;
    x = i;
    y = j;
    state = s;
    tileImage = im;
    tileImage.resize(64,0);
  }
  
  Tile(color tc, int i, int j, char s)
  {
    tileColor = tc;
    x = i;
    y = j;
    state = s;
  }
  
  void set(int t)
  {
    type = t;
  }

  void update(float deltaTime)
  {
    
  }

  void display()
  {
    
      noStroke();
      fill(tileColor);
      rect(x,y,32,32);
      if(tileImage != null)
      {
        image(tileImage,x-32, y-10);
      }
    
    
  }
}
