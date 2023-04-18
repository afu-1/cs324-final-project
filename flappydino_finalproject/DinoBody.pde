class DinoBody {
  color c; // provides the color of the bug body
  float xpos; // provides the x coordinate position
  float ypos; // provides the y coordinate position
  float speed; // holds the value at which the bug will move per frame
  // three floats listed below: used in conjunction within the function hover
  //to provide an angle to use in the transformation, rotate()
  float tilt;
  float angleHover;
  float range = 30.0;

  DinoBody(float xpos, float ypos, float speed) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.speed = speed;
    tilt = 0;
  }

  void display() {
    image(dino, xpos, ypos);
  }

  // function to make the body of the bug bob up and down to emulate flying
  void hover() {
    tilt = cos(angleHover) / range;
    angleHover += 0.1; // increment the angle
    rotate(tilt); // transform to animate movement of the body
  }
  
  // function to make the body of the bug move forward at the speed provided per frame
  void fly() {
    translate(speed, 0); // move the body across the x-axis
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
}
