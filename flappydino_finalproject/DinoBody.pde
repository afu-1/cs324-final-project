//Alli? Ally? (idk how to spell sorry)
class DinoBody {
  float xpos; // provides the x coordinate position
  float ypos; // provides the y coordinate position
  float speed; // holds the value at which the bug will move per frame
  float radius;


  DinoBody(float xpos, float ypos, float speed) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.speed = speed;
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
  void display() {
    //imageMode(CENTER);
    //rectMode(CENTER);
    image(dino, xpos, ypos);
  }
}
