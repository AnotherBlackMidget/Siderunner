class Chunk
{
  public Tile[][] tiles;
  public int abc;
  public color backgroundColor;
  ArrayList<Enemy> enemies;
  ArrayList<Enemy> deadenemies;
  
  Chunk(Tile[][] t, color c, ArrayList<Enemy> e)
  {
    tiles = t;
    backgroundColor = c;
    enemies = e;
  }
}
