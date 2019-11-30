class ChunkConstructor
{
  char biomeType;
  char chunkType;
  Tile[][] tiles;
  color presetColor;
  color backgroundColor;
  int chunkMultiplier;
  PImage tileset;
  
  Chunk ChunkGenerator(char b, char c, int d)
  {
    tileset = loadImage("/Resources/tileset.png");
    Chunk tempChunk;
    biomeType = b;
    chunkType = c;
    chunkMultiplier = d;
    
    
    BiomeSelector();
    TerrainGenerator();
    //EnemyGenerator();
    
    tempChunk = new Chunk(tiles, backgroundColor);
    
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
            tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's', tileset.get(224,0,80,64) );
          }
          else
          {
            tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's');
          }
        }
      break;
      
      //---------------
      
      case 'b':
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
              tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's', tileset.get(224,0,80,64));
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
      
      default:
      for(int x=0; x<96; x++)
        {
          if(x%3 == 2 && x%2 == 1)
          {
            tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's', tileset.get(224,0,80,64) );
          }
          else
          {
            tiles[x/3][x%3] = new Tile(presetColor, ((x/3)*32) + (32*32*chunkMultiplier), height-(x%3)*32-32, 's');
          }
        }
      break;
      
    }
  }
}
