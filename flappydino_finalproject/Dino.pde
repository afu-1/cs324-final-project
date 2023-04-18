// Group #: 11
// Author: Allison Protass
// File Description: defines Dino class, a type of insect that calls on the DinoBody and FrontWing class

// composite of both the DinoBody and FrontWing
class Dino {
  DinoBody critter;
  FrontWing flapper;
  Tail swiper;
  float x, y, r;

  // function initializes the class
  Dino(float _x, float _y, float jumpSpeed, float _r) {
    x = _x;
    y = _y;
    r = _r;
    critter = new DinoBody(x, y, jumpSpeed);
    flapper = new FrontWing(x, y, jumpSpeed);
    swiper = new Tail(x, y, jumpSpeed);
  }
  void display() {
    critter.display();
    flapper.display();
    swiper.display();
  }
  void up() {
    critter.up();
    flapper.up();
    swiper.up();
  }
  void down() {
    critter.down();
    flapper.down();
    swiper.down();
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
