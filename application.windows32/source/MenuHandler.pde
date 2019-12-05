class MenuHandler implements IHandler
{ 
  boolean isLeft, isRight, isUp, isDown, isSpace; 

  Chunk chunk;
  Background bg;
  
  boolean debounce, next;
  
  int selectedBox;
  
  MenuHandler()
  {
    bg = new Background();
  
    selectedBox = 0;
    
    ChunkConstructor gen = new ChunkConstructor();
    
    chunk = gen.ChunkGenerator('1','a',0);
    

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
        return isUp = b;
      
      case 's':
      case 'S':
      case DOWN:
        return isDown = b;
        
      case 'a':
      case 'A':
      case LEFT:
        return isLeft = b;
     
      case 'd':
      case 'D':
      case RIGHT:
        return isRight = b;
      
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
    if(isUp && isDown) {}
    else if(isUp && !debounce)
    {
      if(selectedBox == 0) selectedBox = 2;
      else selectedBox--;
      debounce = true;
    }
    else if(isDown && !debounce)
    {
      if(selectedBox == 2) selectedBox = 0;
      else selectedBox++;
      debounce = true;
    }
    else if(!isUp && !isDown) debounce = false;
    
    if(isSpace)
    {
      switch(selectedBox)
      {
        case 0:
          next = true;
        break;
        
        case 1:
        
        break;
        
        case 2:
          exit();
        break;
      }
    }
  }
  
  //
  //  The rendering
  //
  void display()
  {
    bg.Display();
    for(int j=0; j<96; j++)
    {
      chunk.tiles[j/3][j%3].display();
    }
    
    noStroke();
    fill(color(255,255,100));
    switch(selectedBox)
    {
      case 0:
        rect(width/2-55, height/2-105, 110, 60);
      break;
      
      case 1:
        rect(width/2-55, height/2-30, 110, 60);
      break;
      
      case 2:
        rect(width/2-55, height/2+45, 110, 60);
      break;
    }
    
    stroke(0);
    fill(color(60,64,60));
    
    rect(width/2-50, height/2-100, 100, 50);
    
    rect(width/2-50, height/2-25, 100, 50);
    
    rect(width/2-50, height/2+50, 100, 50);
    
    textAlign(CENTER, CENTER);
    textSize(15);
    fill(255);
    
    text("Start Game", width/2, height/2-75);
    
    text("Useless Button", width/2, height/2);
    
    text("Close Game", width/2, height/2+75);
      
  }
  
  boolean nextState()
  {
    return next;
  }
}
