import java.util.Map;

Dino dinoComp;
PImage dino;
PImage wing;
PImage tail;
float start = 0;

class SideJumper
{
  PImage image;
  PVector position;
  float direction;
  PVector velocity;
  float jumpSpeed;
  float walkSpeed;
}

// GLOBAL VARIABLES

SideJumper dinoBody;
float left;
float right;
float up;
float down;

// half a pixel per frame gravity.
float gravity = .5;

// Y coordinate of ground for collision
float ground = 700;

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
    dino = loadImage("body.png");
    wing = loadImage("wings.png");
    tail = loadImage("tail.png");
    dinoComp = new Dino(100, 500, 2);
    dinoBody = new SideJumper();
    dinoBody.image = loadImage("body.png");
    dinoBody.position = new PVector(400, ground);
    dinoBody.direction = 1;
    dinoBody.velocity = new PVector(0, 0);
    dinoBody.jumpSpeed = 10;
    dinoBody.walkSpeed = 4;
  }

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
  t = new Timer();
  g = new GetInput();
}

void draw() {
  // Lighting and background
  background(0);
  
  if (m.mainOn) {
    m.mainMenu();
    text(g.inputStr,500,500);
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
  if (start == 1) {
    updateDinoBody();
    dinoComp.FlyForward();
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

void updateDinoBody()
{
  // Only apply gravity if above ground (since y positive is down we use < ground)
  if (dinoBody.position.y < ground)
  {
    dinoBody.velocity.y += gravity;
  } else
  {
    dinoBody.velocity.y = 0;
  }

  // If on the ground and "jump" key is pressed set my upward velocity to the jump speed!
  if (dinoBody.position.y >= ground && up != 0)
  {
    dinoBody.velocity.y = -dinoBody.jumpSpeed;
  }

  // We check the nextPosition before actually setting the position so we can
  // not move the dinoBody if he's colliding.
  PVector nextPosition = new PVector(dinoBody.position.x, dinoBody.position.y);
  nextPosition.add(dinoBody.velocity);

  // Check collision with edge of screen and don't move if at the edge
  float offset = 0;
  if (nextPosition.x > offset && nextPosition.x < (width - offset))
  {
    dinoBody.position.x = nextPosition.x;
  }
  if (nextPosition.y > offset && nextPosition.y < (height - offset))
  {
    dinoBody.position.y = nextPosition.y;
  }

  pushMatrix();

  translate(dinoBody.position.x, dinoBody.position.y);


  imageMode(CENTER);
  image(dinoBody.image, 0, 0);

  popMatrix();
}

void keyPressed() {
  if (m.mainOn) {
    g.keyPressed(); // only get string input when the main screen is on
  }
  else if (key == ' ') { // jump command
    up = -1;
  }
  else if (key == 'p') { //pause command
    t.pauseTime();
  }
  else if (key == '\n') { //restart command
    m.endOn = true; // manually end the game
    // Annie can save the timer and name here
    println(t.time); //final time
    println(g.inputStr); //input string
  }
}

void keyReleased()
{
  if (key == ' ') {
    up = 0;
  }
}

void mousePressed() {
  for (int i = 0; i < 6; i++){
    Button b = m.buttons.get(i);
      if (b.isOver()) {
        println(i);
        m.mainOn = false;
        t.startTime();
        start = 1;
      }
  }
}
