class GameHandler implements IHandler
{
  ArrayList<Chunk> chunks;
  int randX;
  int randY;
  Hero hero;
  float distance;
  int tileCount;
  int chunkCount;
  int temp;
  Background bg;
  
  boolean debounce, next;
  
  boolean isRight, isA, isD, isW, isS, isSpace; 
  
  
  GameHandler()
  {
    bg = new Background();
  
    hero = new Hero();
    distance = 0;
    
    Generator gen = new Generator();
    
    chunks = gen.ChunkGeneration();
    chunkCount = gen.chunkCount;
    
    isRight = true;
    next = false;
  }
  
  
  void handle(int deltaTime)
  {
    //temps soit pareil pour tout PC
    currentTime = millis();
    deltaTime = currentTime - previousTime;
  
    update(deltaTime);
    display();
  
    previousTime = currentTime;
  }
  
  
  boolean setMove(int k, boolean b) 
  {
    switch (k) 
    {
      case 'w':
      case 'W':
      case UP:
        return isW = b;
      
      case 's':
      case 'S':
      case DOWN:
        return isS = b;
        
      case 'a':
      case 'A':
      case LEFT:
        return isA = b;
     
      case 'd':
      case 'D':
      case RIGHT:
        return isD = b;
      
      case ' ':
        return isSpace = b;
  
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
    
    if(hero.location.y > height)
    {
      next = true;
    }
    
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
        if(isRight && chunks.get(chunkCount-1).tiles[31][0].x > width)
        {
          chunks.get(i).tiles[j/3][j%3].x-=4;
          //distance++;
        } 
      }
  
      
      for(Enemy e : chunks.get(i).enemies) 
      {
        if(isRight && chunks.get(chunkCount-1).tiles[31][0].x > width)
        {
          e.location.x -=4;
        }
        
  
      }
    }
    
    for(int i = 0; i<2; i++)
    {
      if(chunks.get(i).tiles[31][2].x + 36 < 0 && chunkCount > 2)
      {
        chunks.remove(chunks.get(i));
        chunkCount--;
      }
      
      
      for(Enemy e : chunks.get(i).enemies)
      {
        e.applyForce(gravity);
        e.update(delta);
        if(e.checkHero(hero)) next = true;
      }
      
      for(int j=0; j<96; j++)
      {
        hero.checkEdges(chunks.get(i).tiles[j/3][j%3]);
        for(int k=0; k<2; k++)
        {
          for(Enemy e : chunks.get(k).enemies) 
          {
            e.checkEdges(chunks.get(i).tiles[j/3][j%3]);
          }
        }
      }  
    }
    
    if(isW)
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
    
    
    if(isRight && chunks.get(chunkCount-1).tiles[31][0].x > width)
    {
      bg.Move('r');
      distance++;
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
    /*
    for(int i=0; i<2; i++)
    {
      if(hero.location.x >= chunks.get(i).tiles[0][0].x && hero.location.x < chunks.get(i).tiles[31][0].x + 32)
      {
        background(chunks.get(i).backgroundColor);
      }
    }*/
    
    bg.Display();
    
    for(int i=0; i<2; i++)
    { 
      for(int j=0; j<96; j++)
      {
        chunks.get(i).tiles[j/3][j%3].display();
      }
      for(Enemy e : chunks.get(i).enemies) 
      {
        e.display();
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
  
  boolean nextState()
  {
    return next;
  }
}
