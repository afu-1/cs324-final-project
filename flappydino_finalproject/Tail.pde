//Ally
class Tail {
  float xpos; // provides the x coordinate position
  float ypos; // provides the y coordinate position
  float speed; // holds the value at which the bug will move per frame
  boolean bounce = false; // used for bounce function to determine if bounce() was called
  float d = 0; // used to determine distance a coordinate moved in translation functions
  boolean bounce_up = true; // used for bounce function to determine whether to move wing up or down


  Tail(float xpos, float ypos, float speed) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.speed = speed;
  }

  void display() {
    image(tail, xpos, ypos);
  }
  // updates the position of the object
  void up() {
    translate(0, -10);
    ypos -= 10;
  }
  void down() {
    translate(0, 10);
    ypos += 10;
  }

  void bounce(float speed, float dist) {
    // set speed and distance for tail to bounce
    float speedBound = 2;
    float distBound = 25;

    // constrain distance to be within bounds
    speed = constrain(speed, 0, speedBound);
    dist = constrain(dist, 0, distBound);

    // move tail down
    bounce = true;
    if (bounce_up) {
      if (d > dist) {
        bounce_up = false;
      }
      d += speed;
      ypos += speed;
    } else {
      if (d < 0) {
        bounce_up = true;
      }
      d -= speed;
      ypos -= speed;
    }
  }
}
