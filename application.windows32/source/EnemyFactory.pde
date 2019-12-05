class EnemyFactory
{
  Enemy create(char c, PVector p)
  {
    Enemy enemy = null;
    if(c == 'r')
    {
      enemy = new Runner(p);
    }
    else if(c== 'j')
    {
      enemy = new Jumper(p);
    }
    else if(c == 'f')
    {
      enemy = new Flyer(p);
    }

    return enemy;
  }
}
