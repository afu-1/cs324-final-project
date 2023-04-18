//Ally? Alli?
class Tail {
  float xpos; // provides the x coordinate position
  float ypos; // provides the y coordinate position
  float speed; // holds the value at which the bug will move per frame
  // three floats listed below: used in conjunction within the function hover
  //to provide an angle to use in the transformation, rotate()
  float tilt;
  float angleHover = 0.0;
  float range = 30.0;
  // used for flapWing function to determine whether to translate wing left or right
  boolean flap = true;

  boolean bounce = false; // used for bounce function to determine if bounce() was called
  float d = 0; // used to determine distance a coordinate moved in translation functions
  boolean bounce_up = true; // used for bounce function to determine whether to move petal up or down


  Tail(float xpos, float ypos, float speed) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.speed = speed;
    tilt = 0;
  }

  void display() {
    image(tail, xpos, ypos);
  }
  // function will allow petal to move up and down the stem around the point of the top of the stem
  void bounce(float speed, float dist) {
    // set speed and distance for petal to bounce - to be set by developer
    float SPEED_BOUND = 2;
    float DIST_BOUND = 25;

    // constrain distance to be within bounds
    speed = constrain(speed, 0, SPEED_BOUND);
    dist = constrain(dist, 0, DIST_BOUND);

    // move petal down
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
  void hover() {
    tilt = cos(angleHover) / range;
    pushMatrix();
    rotate(tilt); // transform to animate movement of the wing
    popMatrix();
    angleHover += 0.1; // increment the angle
  }
  // function to make the wing of the bug move forward at the speed provided per frame
  void fly() {
    translate(speed, 0); // move body
    xpos += speed;
    if (xpos > width) { // if the bug goes off screen, it will come back from the other direction
      xpos = 0;
    }
  }

  // function to make the body of the bug fly in a circle
  void circles(float centerx, float centery, float angleFly, float distx, float disty) {
    xpos = centerx + cos(angleFly*speed) * distx;
    ypos = centery + sin(angleFly*speed) * disty;
  }
  // function to make the wing move quickly left and right like it is flapping
  void flapWing() {
    if (flap) {
      translate(speed, 0); // move wing right
      flap = false; // each movement will change the bool in order to trigger the next movement
    } else {
      translate(-speed, 0); // move wing back left
      flap = true; // each movement will change the bool in order to trigger the next movement
    }
  }
}
