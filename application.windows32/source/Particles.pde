class Particles extends GraphicObject
{
  float angle, angleMod;
  int rotVel;
  int timer;
  int size, sizeMod;
  color partColor;
  
  Particles(PVector loc, PVector vel, int t, float a, int s, int sM, color p )
  {
    velocity = vel;
    location = loc;
    timer = t;
    angleMod = a;
    size = s;
    sizeMod = sM;
    partColor = p;
  }
  
  void update(float deltaTime)
  {
    location.add(velocity);
    angle += angleMod;
    size += sizeMod;
    timer--;
  }
  
  void display()
  {
    pushMatrix();
      //rotate(radians(angle));
      translate(location.x, location.y);
      rotate(radians(angle));
      //rectMode(CENTER);
      stroke(1);
      fill(partColor);
      rect(0,0,size,size);
    popMatrix();
  }
}
