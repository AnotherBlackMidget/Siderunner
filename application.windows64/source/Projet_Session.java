import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Projet_Session extends PApplet {

//
//  Variables
//
int currentTime;
int previousTime;
int deltaTime;
IHandler currentState;
boolean game;

public void setup()
{
  
  currentTime = millis();
  deltaTime = millis();
  currentState = new MenuHandler();
  
  
}

public void draw()
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


public void keyPressed() 
{
  currentState.setMove(keyCode, true);
  currentState.setMove(key, true);
}
 
public void keyReleased() 
{
  currentState.setMove(keyCode, false);
  currentState.setMove(key, false);
}
class Animation 
{
  PImage spritesheet;
  PImage[] sprites = new PImage[10];
  
  Animation() 
  {
    spritesheet = loadImage("Resources/SpriteSheet.png");
    int x = 24;
    for(int i = 0; i<8; i++)
    {
      sprites[i] = spritesheet.get(x, 286, 50, 50);
      x+=51;
    }
    sprites[8] = spritesheet.get(126,129,50,50);
    sprites[9] = spritesheet.get(202,129,50,50);
    
    for(int i = 0; i<10; i++)
    {
      sprites[i].resize(64,0);
    }
  }
}
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
  
  public void Move(char d)
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
  
  public void Display()
  {
    //Move();  

    image(back, vback, 0);
    image(middle, vmiddle, 0);    
    image(front, vfront, 0);
    
    
    
    
  }
}
class Chunk
{
  public Tile[][] tiles;
  public int abc;
  public int backgroundColor;
  ArrayList<Enemy> enemies;
  ArrayList<Enemy> deadenemies;
  
  Chunk(Tile[][] t, int c, ArrayList<Enemy> e)
  {
    tiles = t;
    backgroundColor = c;
    enemies = e;
  }
}
class ChunkConstructor
{
  char biomeType;
  char chunkType;
  Tile[][] tiles;
  ArrayList<Enemy> enemies;
  int presetColor;
  int backgroundColor;
  int chunkMultiplier;
  PImage tileset;
  PImage land;
  PImage water;
  EnemyFactory factory;
  
  public Chunk ChunkGenerator(char b, char c, int d)
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
  
  public void BiomeSelector()
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
  
  public void TerrainGenerator()
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
  
  
  
  
  
  
  
  public void EnemyGenerator()
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
abstract class Enemy extends GraphicObject
{
  int health;
  int damage;
  int jumpCount;
  boolean jumpDebounce;
  int w, h;
  boolean loaded = false;
  
  public void checkEdges(Tile t) 
  {
    if(t.state == 's')
    {
      if(t.y < location.y+h-4)
      {
        if(location.x < t.x + 32 && location.x >= t.x + 20)
        {
          location.x = t.x + 32;
        }
        else if(location.x > t.x - w && location.x <= t.x - 4)
        {
          location.x = t.x - w;
        }
      }

      
      if(t.x <= location.x && t.x+32 > location.x)
      {
        if(location.y+h >= t.y && location.y+h-6< t.y)
        {
          jumpCount = 0; 
          location.y = t.y-h;  
          acceleration = new PVector(0,0);
          velocity = new PVector(0,0);
        }
      }
    } 
  }
  
  public boolean checkHero(Hero hero)
  {
    
    if( (hero.location.x+hero.w > location.x && hero.location.x < location.x + w) && (hero.location.y+hero.h > location.y && hero.location.y < location.y + h) )
    {
      //fillColor = color(255,0,0);
      return true;
    }
    else
    {
      return false;
    }
  }
  
  
  public void applyForce (PVector force) 
  {
    PVector f = PVector.div (force, mass);
   
    acceleration.add(f);
  }
}
class EnemyFactory
{
  public Enemy create(char c, PVector p)
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
class Flyer extends Enemy
{  
  Flyer(PVector p)
  {
    location = p;
  
    w = 32;
    h = 16;
    fillColor = color(0,0,255);
  }
  
  public void update(float deltaTime)
  {
    location.x-=6;
  }
  
  public void display()
  {
    fill(fillColor);
    stroke(0);
    rect(location.x,location.y,w,h);
  }
  
  public void checkEdges(Tile t) 
  {
    
  }  
  
  public void applyForce (PVector force) 
  {
    
  }
}
class GameHandler implements IHandler
{
  ArrayList<Chunk> chunks;
  int randX;
  int randY;
  Hero hero;
  float distance;
  int tileCount;
  int chunkCount;
  int temp;
  Background bg;
  
  boolean debounce, next;
  
  boolean isRight, isA, isD, isW, isS, isSpace; 
  
  
  GameHandler()
  {
    bg = new Background();
  
    hero = new Hero();
    distance = 0;
    
    Generator gen = new Generator();
    
    chunks = gen.ChunkGeneration();
    chunkCount = gen.chunkCount;
    
    isRight = true;
    next = false;
  }
  
  
  public void handle(int deltaTime)
  {
    //temps soit pareil pour tout PC
    currentTime = millis();
    deltaTime = currentTime - previousTime;
  
    update(deltaTime);
    display();
  
    previousTime = currentTime;
  }
  
  
  public boolean setMove(int k, boolean b) 
  {
    switch (k) 
    {
      case 'w':
      case 'W':
      case UP:
        return isW = b;
      
      case 's':
      case 'S':
      case DOWN:
        return isS = b;
        
      case 'a':
      case 'A':
      case LEFT:
        return isA = b;
     
      case 'd':
      case 'D':
      case RIGHT:
        return isD = b;
      
      case ' ':
        return isSpace = b;
  
      default:
        return b;
    }
  }
  //
  //  The calculation
  //
  public void update(int delta)
  {
    hero.update(delta);
    float m = hero.mass;
    PVector gravity = new PVector (0, 0.1f * m);
    hero.applyForce(gravity);
    
    if(hero.location.y > height)
    {
      next = true;
    }
    
    if(isA && isD) {}
    else if(isD)
    {
      hero.location.x+=4;
    }
    else if(isA)
    {
      hero.location.x-=4;
    }
    
    for(int i=0; i<chunkCount; i++)
    {
      for(int j=0; j<96; j++)
      {
        if(isRight && chunks.get(chunkCount-1).tiles[31][0].x > width)
        {
          chunks.get(i).tiles[j/3][j%3].x-=4;
          //distance++;
        } 
      }
  
      
      for(Enemy e : chunks.get(i).enemies) 
      {
        if(isRight && chunks.get(chunkCount-1).tiles[31][0].x > width)
        {
          e.location.x -=4;
        }
        
  
      }
    }
    
    for(int i = 0; i<2; i++)
    {
      if(chunks.get(i).tiles[31][2].x + 36 < 0 && chunkCount > 2)
      {
        chunks.remove(chunks.get(i));
        chunkCount--;
      }
      
      
      for(Enemy e : chunks.get(i).enemies)
      {
        e.applyForce(gravity);
        e.update(delta);
        if(e.checkHero(hero)) next = true;
      }
      
      for(int j=0; j<96; j++)
      {
        hero.checkEdges(chunks.get(i).tiles[j/3][j%3]);
        for(int k=0; k<2; k++)
        {
          for(Enemy e : chunks.get(k).enemies) 
          {
            e.checkEdges(chunks.get(i).tiles[j/3][j%3]);
          }
        }
      }  
    }
    
    if(isW)
    {
      hero.jump();
    }
    else
    {
      hero.jumpDebounce = false;
    }
    
    if(isSpace && !debounce)
    {
      hero.fire();
      if(hero.gun.fireMode != "automatic")
      {
        debounce = true;
      }
    }
    else if(!isSpace && debounce)
    {
      debounce = false;
    }
    
    
    if(isRight && chunks.get(chunkCount-1).tiles[31][0].x > width)
    {
      bg.Move('r');
      distance++;
    }
    
    
    for(Particles p : hero.gun.particles) 
    {
      if(p.timer > 0)
      {
        p.update(deltaTime);
      }
      else
      {
        hero.gun.deadparticles.add(p);
      }
    }
    
    for(Particles p : hero.gun.deadparticles)
    {
      hero.gun.particles.remove(p);
    }
    hero.gun.deadparticles.clear();
    
  }
  
  //
  //  The rendering
  //
  public void display()
  {
    /*
    for(int i=0; i<2; i++)
    {
      if(hero.location.x >= chunks.get(i).tiles[0][0].x && hero.location.x < chunks.get(i).tiles[31][0].x + 32)
      {
        background(chunks.get(i).backgroundColor);
      }
    }*/
    
    bg.Display();
    
    for(int i=0; i<2; i++)
    { 
      for(int j=0; j<96; j++)
      {
        chunks.get(i).tiles[j/3][j%3].display();
      }
      for(Enemy e : chunks.get(i).enemies) 
      {
        e.display();
      }
    }
    hero.display();
    for (Particles p : hero.gun.particles) 
    {
        p.display();
    }
    textAlign(BOTTOM, LEFT);
    textSize(20);
    fill(0,0,0);
    text(distance,0,20);
  }
  
  public boolean nextState()
  {
    return next;
  }
}
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
  ArrayList<Chunk> chunks;
  int presetTile;
  int test;
  
  ChunkConstructor chunkCon;
  
  public Generator()
  {
    chunkCon = new ChunkConstructor();
    
    StringGeneration();
  }
  
  public void StringGeneration()
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
  
  public ArrayList<Chunk> ChunkGeneration()
  {
    char[] s = genString.toCharArray();
    chunks = new ArrayList<Chunk>();
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
        chunks.add(chunkCon.ChunkGenerator(biomeType, chunkType, chunkCount2));
        chunkCount2++;
      }
    }
    return chunks;
  }
}
abstract class GraphicObject
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;

  int fillColor = color(255);
  int strokeColor = color(255);
  float strokeWeight = 1;

  public abstract void update(float deltaTime);

  public abstract void display();
}
class Hero extends GraphicObject
{
  int health;
  int jumpCount;
  boolean jumpDebounce;
  int w, h;
  Animation anim;
  int i;
  float i2;
  Weapon gun;
  
  
  Hero()
  {
    gun = new Weapon("flamethrower");
    anim = new Animation();
    location = new PVector(width/2-8, height - 160);
    velocity = new PVector (0, 0);
    acceleration = new PVector (0 , 0);
    w = 32;
    h = 64;
    mass = 10;
    jumpCount = 0;
    jumpDebounce = false;
    i = 0;
  }

  public void update(float deltaTime)
  {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
    
    
    i2 += 0.4f;
    if(i2 >= 8)
    {
      i2 = 0;
    }
    i = (int) i2;

  }

  public void display()
  {
    
      fill(0,255,0);
      //rect(location.x,location.y,w,h);
      
      if(jumpCount == 0)
      {
        image(anim.sprites[i], location.x-14, location.y);
      }
      else
      {
        image(anim.sprites[8], location.x-14, location.y);
      }
  }
  
  public void checkEdges(Tile t) 
  {
    if(t.state == 's')
    {
      if(t.y < location.y+60)
      {
        if(location.x < t.x + 32 && location.x >= t.x + 20)
        {
          location.x = t.x + 32;
        }
        else if(location.x > t.x - w && location.x <= t.x - 4)
        {
          location.x = t.x - w;
        }
      }

      
      if(t.x <= location.x && t.x+32 > location.x)
      {
        if(location.y+h >= t.y && location.y+58< t.y)
        {
          jumpCount = 0; 
          location.y = t.y-h;  
          acceleration = new PVector(0,0);
          velocity = new PVector(0,0);
        }
      }

    }
    
  }
 
  public void applyForce (PVector force) 
  {
    PVector f = PVector.div (force, mass);
   
    acceleration.add(f);
  }
  
  public void jump()
  {
    if(jumpCount < 2 && !jumpDebounce)
    {
      velocity.y = 0;
      acceleration.y = 0;
      PVector force = new PVector (0, -40);
      PVector f = PVector.div (force, mass);
      acceleration.add(f);
      jumpCount++;
      jumpDebounce = true;
    } 
  }
  
  public void fire()
  {
    gun.fire(location);
  }
}
interface IHandler
{
  public void handle(int deltaTime);
  public boolean setMove(int k, boolean b);
  public boolean nextState();
}
class Jumper extends Enemy
{
  Jumper(PVector p)
  {
    location = p;
    velocity = new PVector (0, 0);
    acceleration = new PVector (0 , 0);
    w = 32;
    h = 32;
    mass = 10;
    jumpCount = 0;
    jumpDebounce = false;
    fillColor = color(0,255,0);
  }

  public void update(float deltaTime)
  {
    jump();
    
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0
    
    
    );
    
    location.x-=2;
  }

  public void display()
  {
      fill(fillColor);
      stroke(0);
      rect(location.x,location.y,w,h);
  }
  
  public void jump()
  {
    if(jumpCount < 2)
    {
      velocity.y = 0;
      acceleration.y = 0;
      PVector force = new PVector (0, -40);
      PVector f = PVector.div (force, mass);
      acceleration.add(f);
      jumpCount++;
    } 
  }
}
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
  
  
  public void handle(int deltaTime)
  {
    //temps soit pareil pour tout PC
    currentTime = millis();
    deltaTime = currentTime - previousTime;
  
    update(deltaTime);
    display();
  
    previousTime = currentTime;
  }
  
  
  public boolean setMove(int k, boolean b) 
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
  public void update(int delta)
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
  public void display()
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
  
  public boolean nextState()
  {
    return next;
  }
}
class Particles extends GraphicObject
{
  float angle, angleMod;
  int rotVel;
  int timer;
  int size, sizeMod;
  int partColor;
  
  Particles(PVector loc, PVector vel, int t, float a, int s, int sM, int p )
  {
    velocity = vel;
    location = loc;
    timer = t;
    angleMod = a;
    size = s;
    sizeMod = sM;
    partColor = p;
  }
  
  public void update(float deltaTime)
  {
    location.add(velocity);
    angle += angleMod;
    size += sizeMod;
    timer--;
  }
  
  public void display()
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
class Runner extends Enemy
{  
  Runner(PVector p)
  {
    location = p;
    velocity = new PVector (0, 0);
    acceleration = new PVector (0 , 0);
    w = 32;
    h = 64;
    mass = 10;
    fillColor = color(255,0,0);
  }

  public void update(float deltaTime)
  {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
    location.x-=4;
  }


  public void display()
  {
      fill(fillColor);
      stroke(0);
      rect(location.x,location.y,w,h);
  }
}
class Tile extends GraphicObject
{
  int tileColor;
  int type;
  int x;
  int y;
  char state;
  PImage tileImage;
  
  Tile(int tc, int i, int j, char s, PImage im)
  {
    tileColor = tc;
    x = i;
    y = j;
    state = s;
    tileImage = im;
    tileImage.resize(64,0);
  }
  
  Tile(int tc, int i, int j, char s)
  {
    tileColor = tc;
    x = i;
    y = j;
    state = s;
  }
  
  public void set(int t)
  {
    type = t;
  }

  public void update(float deltaTime)
  {
    
  }

  public void display()
  {
    
      noStroke();
      fill(tileColor);
      rect(x,y,32,32);
      if(tileImage != null)
      {
        image(tileImage,x-32, y-10);
      }
    
    
  }
}
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
  
  public void fire(PVector l)
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
  public void settings() {  size(720, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Projet_Session" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
