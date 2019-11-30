class Weapon
{
  ArrayList<Particles> particles = new ArrayList<Particles>();
  ArrayList<Particles> deadparticles = new ArrayList<Particles>();
  
  String weaponType;
  String fireMode;
  
  Weapon(String weapon)
  {
    switch(weapon)
    {
      case "flamethrower":
        weaponType = "flamethrower";
        fireMode = "automatic";
        break;
        
      case "shotgun":
        weaponType = "shotgun";
        fireMode = "semi-automatic";
        break;
        
      case "aa12":
        weaponType = "shotgun";
        fireMode = "automatic";
        break;
        
      case "assault rifle":
        weaponType = "rifle";
        fireMode = "automatic";
        break;
        
      case "battle rifle":
        weaponType = "rifle";
        fireMode = "burst";
        break;
    }
  }
  
  void fire(PVector l)
  {
    switch(weaponType)
    {
      case "flamethrower":
        for(int i =0 ; i<12; i++)
        {
          Particles p = new Particles(new PVector(l.x+34,l.y+22), new PVector(random(5,15), randomGaussian()), 10+i, randomGaussian(), 1, 1, color( 255, random(0,255), 0));
          particles.add(p);
        }
        break;
        
      case "shotgun":
        for(int i =0 ; i<20; i++)
        {
          Particles p = new Particles(new PVector(l.x+34,l.y+22), new PVector(random(8,12), randomGaussian()), 5+i, randomGaussian(), 4, 0, color( 255, 253, 109) );
          particles.add(p);
        }
        
      case "rifle":
      
        if(fireMode == "burst")
        {
          for(int i = 0; i<3; i++)
          {
            Particles p = new Particles(new PVector(l.x+34,l.y+22), new PVector(random( 15,20), randomGaussian()/4), 25+i , 0, 4, 0, color( 255, 253, 109) );
            particles.add(p);
          }
        }
        else
        {
          Particles p = new Particles(new PVector(l.x+34,l.y+22), new PVector(random( 15,20), randomGaussian()/6), (int) random(20,30) , 0, 4, 0, color( 255, 253, 109) );
          particles.add(p);
        }        
        break;
    }
  }
  
  
}
