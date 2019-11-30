class Animation 
{
  PImage spritesheet;
  PImage[] sprites = new PImage[10];
  
  Animation() 
  {
    spritesheet = loadImage("Resources/SpriteSheet.png");
    int x = 24;
    for(int i = 0; i<8; i++)
    {
      sprites[i] = spritesheet.get(x, 286, 50, 50);
      x+=51;
    }
    sprites[8] = spritesheet.get(126,129,50,50);
    sprites[9] = spritesheet.get(202,129,50,50);
    
    for(int i = 0; i<10; i++)
    {
      sprites[i].resize(64,0);
    }
  }
}
