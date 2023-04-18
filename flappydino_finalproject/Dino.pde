// Group #: 11
// Author: Allison Protass
// File Description: defines Dino class, a type of insect that calls on the DinoBody and FrontWing class

// initialize the angle variable
float angleFly = 0.0;

// composite of both the DinoBody and FrontWing
class Dino {
  DinoBody critter;
  FrontWing flapper;
  Tail swiper;

  // function initializes the class
  Dino(float xpos, float ypos, float speed) {
    critter = new DinoBody(xpos, ypos, speed);
    flapper = new FrontWing(xpos, ypos, speed);
    swiper = new Tail(xpos, ypos, speed);
  }
  void display() {
    critter.display();
    flapper.display();
    swiper.display();
  }
  // combined functions to make a simple call for the entire Dino to fly
  void FlyForward() {
    critter.display();
    flapper.bounce(1, 1);
    flapper.display();
    swiper.bounce(1, 1);
    swiper.display();
  }

}
