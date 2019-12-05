//
//  Variables
//
int currentTime;
int previousTime;
int deltaTime;
IHandler currentState;
boolean game;

void setup()
{
  size(720, 480);
  currentTime = millis();
  deltaTime = millis();
  currentState = new MenuHandler();
  
  
}

void draw()
{
  //temps soit pareil pour tout PC
  currentTime = millis();
  deltaTime = currentTime - previousTime;

  currentState.handle(deltaTime);
  
  if(currentState.nextState())
  {
    if(!game)
    {
      currentState = new GameHandler();
      game = true;
    }
    else
    {
      currentState = new MenuHandler();
      game = false;
    }
  }

  previousTime = currentTime;
}


void keyPressed() 
{
  currentState.setMove(keyCode, true);
  currentState.setMove(key, true);
}
 
void keyReleased() 
{
  currentState.setMove(keyCode, false);
  currentState.setMove(key, false);
}
