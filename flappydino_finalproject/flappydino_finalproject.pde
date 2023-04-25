// For music
import ddf.minim.*;
Minim minim;
AudioPlayer player;
boolean startUp; // boolean to start music

import java.util.Map; //for hashmap

Dino dinoComp;
PImage dino;
PImage wing;
PImage tail;
float start = 0;

// Classes
Scores score_sheet;
Car[] carArray; // array of obstacles
Ground ground; // ground
Cloud[] cloudArray; // array of clouds
Tree tree; // tree

//global objects
JSONArray colors;
HashMap<String, Integer> color_values = new HashMap<String, Integer> ();

PImage sprite;
Table scores;
PFont score_font;

// Jose's global variables
float carHeight;
float carWidth;

// Anthony GUI's
Button b;
Timer t;
Menu m;
GetInput g;


void setup() {

  size(1000, 1000);
  frameRate(60);
  imageMode(CENTER);
  rectMode(CENTER);
  // For music
  minim = new Minim(this);
  player = minim.loadFile("lofi.mp3");
  startUp = true;

  //set colors of the sprite and load the sprite image - Annie
  colors = loadJSONArray("colors.json");
  sprite = loadImage("sprite.png");

  //set color hashmap values - Annie
  for (int i = 0; i < colors.size(); i++) {
    JSONObject c = colors.getJSONObject(i);

    String key_input = c.getString("color");
    String red = c.getString("R");
    String green = c.getString("G");
    String blue = c.getString("B");

    color_values.put(key_input, color(int(red), int(green), int(blue)));
  }

  dino = loadImage("body.png");
  wing = loadImage("wings.png");
  tail = loadImage("tail.png");

  //sets score font and text - Annie
  score_font = createFont("Butterbean.otf", 30);
  textFont(score_font);

  //scores sheet - Annie
  scores = new Table();
  scores.addColumn("name", Table.STRING);
  scores.addColumn("score", Table.INT);

  saveTable(scores, "scores.csv"); //creates new table

  //initialize classes
  score_sheet = new Scores(scores);

  // Fixed car width and height
  carWidth = width / 10;
  carHeight = height / 10;

  // Ground
  color groundColor = color(0, 255, 0);
  float groundHeight = 100;
  float groundWidth = width;
  ground = new Ground(groundColor, groundWidth, groundHeight);

  // Tree
  float tx = width; // tree will come in from the right
  float ty = height - groundHeight - carHeight;
  float tvx = -1;
  float tvy = 0;
  float tscale = 1;
  color leafColor = color(69, 155, 73);
  color trunkColor = color(133, 76, 0);
  tree = new Tree(tx, ty, tvx, tvy, tscale, carWidth, carHeight, leafColor, trunkColor);

  // Clouds
  int numOfClouds = 3; // the number of clouds at a time
  cloudArray = new Cloud[numOfClouds];

  // Clouds will come in from the right
  for (int i = 0; i < cloudArray.length; i++) {

    // Create clouds (spawn on right side)
    float x = width;
    float y = random(carHeight/2, height/2 - carHeight/2 + 1);
    float vx = -random(0.25, 0.5);
    float vy = 0;
    float scale = 0.5;
    Cloud cl = new Cloud(x, y, vx, vy, scale, carWidth, carHeight);

    // Put into array
    cloudArray[i] = cl;
  }

  // Initalize car array
  int numOfCars = 6; // the number of obstacles at a time
  carArray = new Car[numOfCars];

  // Obstacles will come in from the right
  for (int i = 0; i < carArray.length; i++) {

    // Create cars (spawn on right side)
    float x = width; // right side
    float y = random(carHeight / 2, height - carHeight / 2 + 1);
    float vx = -random(1, 6);
    float vy = 0;
    float scale = 1;
    Car c = new Car(x, y, vx, vy, scale, width/10, height/10);

    // Put into array
    carArray[i] = c;
  }
  //Anthony GUI classes
  m = new Menu();
  m.createButtons();
  m.createDinos();
  t = new Timer();
  g = new GetInput();
}

void draw() {

  // For music
  if (player.position() == player.length()) { // If player has reached the end

    // Rewind player
    player.rewind();

    // Play player
    player.play();
  }

  // Lighting and background
  background(44, 198, 194);
  if (m.mainOn) {
    m.mainMenu();
    textSize(16);
    text("Please enter a character name: " + g.inputStr, 50, 450);
    return;
  } 
  else if (m.endOn) {
    
    return;
  }

  if (startUp) {
    player.play();
    startUp = false;
  }


  t.display();

  // Display ground
  ground.display();

  // Display tree
  tree.display();

  // Move tree
  tree.move();

  // Respawn tree
  if (tree.isOutOfBounds()) {

    // New parameters
    float groundHeight = 100;
    float tx = width; // tree will come in from the right
    float ty = height - groundHeight - carHeight;
    float tvx = -1;
    float tvy = 0;
    float tscale = 1;
    tree.respawn(tx, ty, tvx, tvy, tscale);
  }

  // Display all particles
  for (int i = 0; i < carArray.length; i++) {
    carArray[i].display();
  }

  // Move all particles
  for (int i = 0; i < carArray.length; i++) {
    carArray[i].move();
  }

  // Respawn cars that havge gone off-screen (cars that started on the right)
  for (int i = 0; i < carArray.length; i++) {

    // Check for cars that have gone out of bounds
    if (carArray[i].isOutOfBounds()) {

      // New parameters
      float x = width;
      float y = random(carArray[i].carHeight / 2, height - carArray[i].carHeight / 2 + 1);
      float vx = -random(1, 6);
      float vy = 0;
      float scale = 1;

      // Respawn the car
      carArray[i].respawn(x, y, vx, vy, scale);
    }
  }

  // Display all clouds
  for (int i = 0; i < cloudArray.length; i++) {
    cloudArray[i].display();
  }

  // Move all clouds
  for (int i = 0; i < cloudArray.length; i++) {
    cloudArray[i].move();
  }

  // Respawn clouds that have gone off-screen
  for (int i = 0; i < cloudArray.length; i++) {

    // Check for clouds that have gone out of bounds
    if (cloudArray[i].isOutOfBounds()) {

      // New parameters
      float x = width;
      float y = random(carHeight/2, height/2 - carHeight/2 + 1);
      float vx = -random(0.25, 0.5);
      float vy = 0;
      float scale = 0.5;

      // Respawn the cloud
      cloudArray[i].respawn(x, y, vx, vy, scale);
    }
  }


  dinoComp.FlyForward();
  for (int i = 0; i < carArray.length; i++) {
    m.endOn = dinoComp.checkHealth(carArray[i]);
    if (m.endOn){
      score_sheet.set_score(g.inputStr, t.time);
      //m.endOn = true; // manually end the game
      m.mainMenu(); //display game over sign
      score_sheet.display(); //displays score sheet on top of main menu
      return ;
    }
  }
}

//reference for color values
//image(sprite, 0, 0);

/*
void mousePressed() {
 */


void keyPressed() {
  if (m.mainOn) {
    g.keyPressed(); // only get string input when the main screen is on
  } else if (key == CODED) {
    if (keyCode == UP) {
      dinoComp.up();
    }
    if (keyCode == DOWN) {
      dinoComp.down();
    } else if (key == 'p') { //pause command t.pauseTime() sets t.pause =  true
      t.pauseTime();
    }
  } else if (key == '\n') { //restart command
    // IMPLEMENT THIS AS THE LOSE CONDITION FOR HIT BOX

    //saves the score into csv file
    score_sheet.set_score(g.inputStr, t.time);
    m.endOn = true; // manually end the game
    m.mainMenu(); //display game over sign
    score_sheet.display(); //displays score sheet on top of main menu
  }

  // For music
  // If lowercase m is pressed
  if (key == 'm' && !startUp) {

    if (player.isPlaying()) { // If the player is playing
      // Pause player
      player.pause();
    } else if (player.position() == player.length()) { // If player has reached the end
      // Rewind player
      player.rewind();
      // Play player
      player.play();
    } else {
      player.play();
    }
  }
}

void mousePressed() {
  for (int i = 0; i < 6; i++) {
    Button b = m.buttons.get(i);
    if (b.isOver()) {
      //println("clicked");
      dinoComp = new Dino(100, 500, 2, b.filler);
      m.mainOn = false;
      t.startTime();
      start = 1;
    }
  }
  Button b = m.buttons.get(6);
  if (m.endOn){
    if ((mouseX >= 800) && (mouseY <= 100)){
      exit();
  }
}
}
