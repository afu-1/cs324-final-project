import java.util.Map; //for hashmap

Dino player;
PImage dino;
PImage wing;
PImage tail;
float start = 0;


//classes
Scores score_sheet;
Car[] carArray; // array of obstacles

//global objects
JSONArray colors;
HashMap<String, Integer> color_values = new HashMap<String, Integer> ();

PImage sprite;
Table scores;
PFont score_font;

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
  player = new Dino(100, 500, 2, 100, 100);

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

  // Initalize car array
  int numOfCars = 3; // the number of obstacles at a time
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
  // Lighting and background
  background(0);

  if (m.mainOn) {
    m.mainMenu();
    text(g.inputStr, 500, 500);
    return;
  }
  if (m.endOn) {
    m.mainMenu();
    return;
  }

  t.display();

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
  player.FlyForward();
  for (int i = 0; i < carArray.length; i++) {
  checkHealth(player, carArray[i]);
  }
}


//sets scores using score class - Annie (will remove this when input data is available)
//for (int i = 0; i < 5; i++){
//  score_sheet.set_score(str(i), i * 300);
//}

//displays the scores sheet (feel free to comment out)- Annie
//score_sheet.display();

//reference for color values
//tint(color_values.get("red"));
//image(sprite, 0, 0);

/*
void mousePressed() {
 start = 1;
 //once the mouse is pressed at the beginning (which you had to do anyways because that's the only way the character will start jumping) then this variable changes, indicating the game can begin
 }
 */

boolean overEnemy(float eneX, float eneY, float eneR, float playerX, float playerY, float playerH, float playerW) {
    float testX = eneX;
    float testY = eneY;

    // which edge is closest?
    if (eneX < playerX)         testX = playerX;      // test left edge
    else if (eneX > playerX+playerW) testX = playerX+playerW;   // right edge
    if (eneY < playerY)         testY = playerY;      // top edge
    else if (eneY > playerY+playerH) testY = playerY+playerH;   // bottom edge

    // get distance from closest edges
    float distX = eneX-testX;
    float distY = eneY-testY;
    float distance = sqrt( (distX*distX) + (distY*distY) );

    // if the distance is less than the radius, collision!
    if (distance <= eneR) {
      return true;
    }
    return false;
  }

  void checkHealth(Dino _player, Car e) {
    if (overEnemy(e.r.x, e.r.y, e.carWidth, _player.x, _player.y, _player.w, _player.h)) {
      print("game over");
    }
  }



void keyPressed() {
  if (m.mainOn) {
    g.keyPressed(); // only get string input when the main screen is on
  } else if (key == CODED) {
    if (keyCode == UP) {
      player.up();
    }
    if (keyCode == DOWN) {
      player.down();
    }
  } else if (key == 'p') { //pause command t.pauseTime() sets t.pause =  true
    t.pauseTime();
  } else if (key == '\n') { //restart command
    //println(t.time); //final time
    //println(g.inputStr); //input string

    //saves the score into csv file
    score_sheet.set_score(g.inputStr, t.time);
    m.endOn = true; // manually end the game
    m.mainMenu(); //display game over sign
    score_sheet.display(); //displays score sheet on top of main menu
  }
}


void mousePressed() {
  for (int i = 0; i < 6; i++) {
    Button b = m.buttons.get(i);
    if (b.isOver()) {
      println(i);
      m.mainOn = false;
      t.startTime();
      start = 1;
    }
  }
}
