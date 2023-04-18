color yellow = #E3CE62;
color skyBlue = #94CCF5;
color red = #BF231B;
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

void setup() {
  size(1000, 800);
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

void draw() {
  background(skyBlue);
  if (start == 1) {
    updateDinoBody();
    dinoComp.FlyForward();
  }
}

void mousePressed() {
  start = 1;
  //once the mouse is pressed at the beginning (which you had to do anyways because that's the only way the character will start jumping) then this variable changes, indicating the game can begin
}

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
  if (key == ' ') {
    up = -1;
  }
}

void keyReleased()
{
  if (key == ' ') {
    up = 0;
  }
}
