class Background
{
  PImage back, middle, front;
  public float vback, vmiddle, vfront;
  //boolean isLeft, isRight;
  char c;
  
  Background()
  {
    back = loadImage("Resources/back.png");
    middle = loadImage("Resources/middle.png");
    front = loadImage("Resources/front.png");
    
    vback = 0;
    vmiddle = 0;
    vfront = 0;
    
    back.resize(0,384);
    middle.resize(0,384);
    front.resize(0,384);
    
    
  }
  
  void Move(char d)
  {
    
    if(d == 'r')
    {
      vfront-=4;
      vmiddle-=2;
      vback-=1;
    }
    else if(d == 'l')
    {
      vfront+=4;
      vmiddle+=2;
      vback+=1;
    }
    
    
    
    if(vback <= -(back.width/9))
      {
        vback += back.width/9;
      }
      if(vmiddle <= -(middle.width/5))
      {
        vmiddle += middle.width/5;
      }
      if(vfront <= -(front.width/2))
      {
        vfront += front.width/2;
      }
      
  }
  
  void Display()
  {
    //Move();  

    image(back, vback, 0);
    image(middle, vmiddle, 0);    
    image(front, vfront, 0);
    
    
    
    
  }
}
