class ChunkConstructor
{
  char biomeType;
  char chunkType;
  Tile[][] tiles;
  ArrayList<Enemy> enemies;
  color presetColor;
  color backgroundColor;
  int chunkMultiplier;
  PImage tileset;
  PImage land;
  PImage water;
  EnemyFactory factory;
  
  Chunk ChunkGenerator(char b, char c, int d)
  {
    tileset = loadImage("/Resources/tileset.png");
    Chunk tempChunk;
    biomeType = b;
    chunkType = c;
    chunkMultiplier = d;
    
    factory = new EnemyFactory();
    
    BiomeSelector();
    TerrainGenerator();
    EnemyGenerator();
    
    tempChunk = new Chunk(tiles, backgroundColor, enemies);
    
    return tempChunk;
  }
  
  void BiomeSelector()
  {
    /*
    switch(biomeType)
    {
      case '1':
        presetColor = color(50, 200, 50);
        backgroundColor = color(50, 200, 50);
        //Set Enemy list
        //Set Paralax background
      break;
        
      case '2':
        presetColor = color(255, 229, 204);
        backgroundColor = color(255, 229, 204);
        //Set Enemy list
        //Set Paralax background
      break;
        
      case '3':
        presetColor = color(255, 255, 255);
        backgroundColor = color(255, 255, 255);
        //Set Enemy list
        //Set Paralax background
      break;
        
      case '4':
        presetColor = color(0, 102, 51);
        backgroundColor = color(0, 102, 51);
        //Set Enemy list
        //Set Paralax background
      break;
        
      case '5':
        presetColor = color(100, 100, 100);
        backgroundColor = color(100, 100, 100);
        //Set Enemy list
        //Set Paralax background
      break;   
    }
    */
    land = tileset.get(224,0,80,64);
    water = tileset.get(224, 80, 64, 32);
    presetColor = color(30,32,30);
    backgroundColor = color(30,32,30);
  }
  
  void TerrainGenerator()
  {
    tiles = new Tile[32][3];
    
    switch(chunkType)
    {
      case 'a':
        for(int x=0; x<96; x++)
        {
          if(x%3 == 2 && x%2 == 1)
          {
            tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's', land );
          }
          else
          {
            tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's');
          }
        }
      break;
      
      //---------------
      
      case 'b':
      case 'e':
        for(int x=0; x<96; x++)
        {
          if(x%3 == 2)
          {
            tiles[x/3][x%3] = new Tile(color(0, 119, 190), ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 'l');
          }
          else
          {
            if(x%2 == 1)
            {
              tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's');
            }
            else
            {
              tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's');
            }
          }
        }
        
      break;
      
      //---------------
      
      case 'c':
        for(int x=0; x<96; x++)
        {
          if(x%3 == 0)
          {
            tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's');
          }
          else
          {
            tiles[x/3][x%3] = new Tile(color(0, 119, 190), ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 'l');
          }
        }
      break;
      
      //---------------
      
      case 'g':
      case 'j':
      case 'r':
        for(int x=0; x<96; x++)
        {
          if(x/3 < 14 || x/3 > 23)
          {
            if(x%3 == 2 && x%2 == 1)
            {
              tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's', land );
            }
            else
            {
              tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's');
            }
          }
          else
          {
            tiles[x/3][x%3] = new Tile(color(15,16,15), ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 'a');
          }
        }
      break;
      
      //---------------
      
      case 'k':
      case 'n':
      case 'y':
        for(int x=0; x<96; x++)
        {
          if( x/3 < 4 || ( x/3 > 11 && x/3 < 14) || (x/3 > 19 && x/3 < 24 ) || x/3 > 29 )
          {
            if(x%3 == 2 && x%2 == 1)
            {
              tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's', land );
            }
            else
            {
              tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's');
            }
          }
          else
          {
            tiles[x/3][x%3] = new Tile(color(15,16,15), ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 'a');
          }
        }
      break;
      
      //---------------
      default:
      for(int x=0; x<96; x++)
        {
          if(x%3 == 2 && x%2 == 1)
          {
            tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's', land );
          }
          else
          {
            tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's');
          }
        }
      break;
      
    }
  }
  
  
  
  
  
  
  
  void EnemyGenerator()
  {  
    enemies = new ArrayList<Enemy>();
    switch(chunkType)
    {
      case 'a':
        
      break;
      
      //---------------
      
      case 'b':
        
        
      break;
      
      //---------------
      
      case 'c':
        
      break;
      
      //---------------
      
      case 'd':
        enemies.add(factory.create('r', new PVector(5*32 + (32*32*chunkMultiplier), height-(32*8))));
        
        enemies.add(factory.create('r', new PVector(25*32 + (32*32*chunkMultiplier), height-(32*8))));
      break;
      
      //---------------
      
      case 'e':
        enemies.add(factory.create('j', new PVector(5*32 + (32*32*chunkMultiplier), height-(32*8))));
        
        enemies.add(factory.create('j', new PVector(25*32 + (32*32*chunkMultiplier), height-(32*8))));
      break;
      
      //---------------
      
      case 'f':
        enemies.add(factory.create('f', new PVector(5*32 + (32*32*chunkMultiplier), random(200, height-(32*4)))));
        
        enemies.add(factory.create('r', new PVector(25*32 + (32*32*chunkMultiplier), height-(32*8))));
      break;
      
      //---------------
      
      case 'h':
        enemies.add(factory.create('j', new PVector(5*32 + (32*32*chunkMultiplier), random(200, height-(32*4)))));
        
        enemies.add(factory.create('f', new PVector(15*32 + (32*32*chunkMultiplier), height-(32*8))));
        
        enemies.add(factory.create('r', new PVector(5*32 + (32*32*chunkMultiplier), height-(32*8))));
      break;
      
      //---------------
      
      case 'j':
        enemies.add(factory.create('r', new PVector(5*32 + (32*32*chunkMultiplier), random(200, height-(32*4)))));
        
        enemies.add(factory.create('j', new PVector(15*32 + (32*32*chunkMultiplier), height-(32*8))));
        
        enemies.add(factory.create('f', new PVector(5*32 + (32*32*chunkMultiplier), height-(32*8))));
      break;
      
      //---------------
      
      case 'g':
      case 'n':
      case 'y':
        enemies.add(factory.create('f', new PVector(5*32 + (32*32*chunkMultiplier), random(200, height-(32*4)))));
        
        enemies.add(factory.create('f', new PVector(25*32 + (32*32*chunkMultiplier), random(200, height-(32*4)))));
      break;
      
      //---------------
      
      default:
      
        enemies.add(factory.create('r', new PVector(5*32 + (32*32*chunkMultiplier), height-(32*8))));
        
        enemies.add(factory.create('f', new PVector(15*32 + (32*32*chunkMultiplier), random(200, height-(32*4)))));
        
        enemies.add(factory.create('j', new PVector(25*32 + (32*32*chunkMultiplier), height-(32*8))));
      
      break;
      
    }
  }
}
