//
//  Variables
//
int currentTime;
int previousTime;
int deltaTime;
Tile[][] tiles; // = new Tile[50][3];
Chunk[] chunks;
int randX;
int randY;
Hero hero;
float distance;
PImage sprite;
int tileCount;
int chunkCount;
int temp;
Background bg;

boolean debounce;

boolean isLeft, isRight, isUp, isDown, isA, isD, isW, isS, isSpace; 

void setup()
{
  size(720, 480);
  currentTime = millis();
  deltaTime = millis();
  //sprite = loadImage("Sprite.png");
  
  bg = new Background();
  
  hero = new Hero();
  distance = 0;
  
  Generator gen = new Generator();
  
  //tiles = gen.Generate();
  //tileCount = gen.tileCount;
  
  chunks = gen.ChunkGeneration();
  chunkCount = gen.chunkCount;
  
  
  
  //frameRate(24);
}

void draw()
{
  //temps soit pareil pour tout PC
  currentTime = millis();
  deltaTime = currentTime - previousTime;

  update(deltaTime);
  display();

  previousTime = currentTime;
}


void keyPressed() 
{
  setMove(keyCode, true);
  setMove(key, true);
}
 
void keyReleased() 
{
  setMove(keyCode, false);
  setMove(key, false);
}

boolean setMove(int k, boolean b) 
{
  switch (k) {
  case UP:
    return isUp = b;
 
  case DOWN:
    return isDown = b;
 
  case LEFT:
    return isLeft = b;
 
  case RIGHT:
    return isRight = b;
  
  case ' ':
    return isSpace = b;
    
  case 'w':
    return isW = b;
 
  case 'a':
    return isA = b;
 
  case 's':
    return isS = b;
 
  case 'd':
    return isD = b;
 
 
  default:
    return b;
  }
}
//
//  The calculation
//
void update(int delta)
{
  hero.update(delta);
  float m = hero.mass;
  PVector gravity = new PVector (0, 0.1 * m);
  hero.applyForce(gravity);
  
  
  
  if(isA && isD) {}
  else if(isD)
  {
    hero.location.x+=4;
  }
  else if(isA)
  {
    hero.location.x-=4;
  }
  
  for(int i=0; i<chunkCount; i++)
  {
    for(int j=0; j<96; j++)
    {
      if(isRight && isLeft) {}
      else if(isRight && chunks[chunkCount-1].tiles[31][0].x > width)
      {
        chunks[i].tiles[j/3][j%3].x-=4;
        //distance++;
      }
      else if(isLeft && distance > 0)
      {
        chunks[i].tiles[j/3][j%3].x+=4;
        //distance--;
      }
      
      hero.checkEdges(chunks[i].tiles[j/3][j%3]);
      
      /*
      if(chunks[i].tiles[31][2].x < 0)
      {
        chunks.remove(chunk
      }
      */
    }
  }
  
  if(isUp || isW)
  {
    hero.jump();
  }
  else
  {
    hero.jumpDebounce = false;
  }
  
  if(isSpace && !debounce)
  {
    hero.fire();
    if(hero.gun.fireMode != "automatic")
    {
      debounce = true;
    }
  }
  else if(!isSpace && debounce)
  {
    debounce = false;
  }
  
  
  if(isRight && isLeft) {}
  else if(isRight && chunks[chunkCount-1].tiles[31][0].x > width)
  {
    bg.Move('r');
    distance++;
  }
  else if(isLeft && distance > 0)
  {
    bg.Move('l');
    distance--;
  }
  
  for(Particles p : hero.gun.particles) 
  {
    if(p.timer > 0)
    {
      p.update(deltaTime);
    }
    else
    {
      hero.gun.deadparticles.add(p);
    }
  }
  
  for(Particles p : hero.gun.deadparticles)
  {
    hero.gun.particles.remove(p);
  }
  hero.gun.deadparticles.clear();
  
}

//
//  The rendering
//
void display()
{
  
  for(int i=0; i<chunkCount; i++)
  {
    if(hero.location.x >= chunks[i].tiles[0][0].x && hero.location.x < chunks[i].tiles[31][0].x + 32)
    {
      background(chunks[i].backgroundColor);
      
    }
  }
  
  bg.Display();
  
  for(int i=0; i<chunkCount; i++)
  { 
    for(int j=0; j<96; j++)
    {
      chunks[i].tiles[j/3][j%3].display();
    }
  }
  hero.display();
  for (Particles p : hero.gun.particles) 
  {
      p.display();
  }
  textAlign(BOTTOM, LEFT);
  textSize(20);
  fill(0,0,0);
  text(distance,0,20);
}
