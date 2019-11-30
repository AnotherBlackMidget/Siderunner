class Generator
{
  String genString;
  int biomes;
  int biomeSize;
  char biomeType;
  int chunkCount, chunkCount2;
  char chunkType;
  int tileCount;
  Tile[][] tiles;
  Chunk[] chunks;
  color presetTile;
  int test;
  
  ChunkConstructor chunkCon;
  
  public Generator()
  {
    chunkCon = new ChunkConstructor();
    
    StringGeneration();
  }
  
  void StringGeneration()
  {
    genString = "("; // () = Map Start/End 
    
    biomes = (int) random(2,6);
    for(int i = 0; i<biomes; i++) 
    {
      biomeType = (char) random(49,54); genString += biomeType; // 1 = Grass, 2 = Desert, 3 = Snow, 4 = Forest, 5 = Cave
      genString += '['; // [] = Biome Start/End
      
      biomeSize = (int) random(3,8);
      for(int j = 0; j<biomeSize; j++)
      {
        if(chunkCount != 0)
        {
          chunkType = (char) random(98,108); genString += chunkType; // a = Empty, z = End
          //genString += '{'; // {} = Chunk Start/End
          
          //Chunk Content
          
          //genString += '}';
          chunkCount++;
        }
        else
        {
          chunkType = 'a'; genString += chunkType; // 0 = Empty
          //genString += '{';
          //genString += '}';
          chunkCount++;
        }
      }
      if(i == biomes-1)
      {
        genString += 'z';
        //chunkCount++;
      }
      genString += ']';

    }
    
    genString += ')';
    
    tileCount = chunkCount*32;
    
    test = chunkCount;
    println(genString);
    println(chunkCount);
    println(tileCount);
  }
  
  Chunk[] ChunkGeneration()
  {
    char[] s = genString.toCharArray();
    chunks = new Chunk[chunkCount];
    chunkCount2 = 0;
    
    for(int k=0; k<genString.length(); k++)
    {
      //---------------------------------------Finds the biome type-----------------------------------
      if(k+1<genString.length())
      {
        if(s[k+1] == '[')
        {
          biomeType = s[k];
        }
      }
      
      //-------------------------------Finds chunk type and generates chunk---------------------------
      if(s[k] >= 97 && s[k] <= 108)
      {
        chunkType = s[k];
        chunks[chunkCount2] = chunkCon.ChunkGenerator(biomeType, chunkType, chunkCount2);
        chunkCount2++;
      }
    }
    return chunks;
  }
   




  Tile[][] Generate()
  {
    char[] s = genString.toCharArray();
    tiles = new Tile[tileCount][3];
    chunkCount2 = 0;
    
    for(int k=0; k<genString.length(); k++)
    {
      //********************************************************************************
    
      
      
      //-------------------------------Actual Generator, Converts string char biome type to actual chunk---------------------------
      if(s[k] >= 97 && s[k] <= 108)
      {
        for(int i=0; i<32; i++)
        {
          for(int j=0; j<3; j++)
          {
            tiles[i+(32*chunkCount2)][j] = new Tile(presetTile, (i+(32*chunkCount2) )*32, height-j*32-32, 's');
          }
        }
        chunkCount2++;
      }
      
    }

    return tiles;
  }
  
  
}
