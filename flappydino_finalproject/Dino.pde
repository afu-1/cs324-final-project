//Ally

// composite of both the DinoBody and FrontWing
class Dino {
  DinoBody critter;
  FrontWing flapper;
  Tail swiper;
  int filler;
  float x, y, w, h;
  // function initializes the class
  Dino(float _x, float _y, float jumpSpeed, int filler) {
    x = _x;
    y = _y;
    this.filler = filler;
    //w = _w;
    //h = _h;
    critter = new DinoBody(x, y, jumpSpeed);
    flapper = new FrontWing(x, y, jumpSpeed);
    swiper = new Tail(x, y, jumpSpeed);
  }
  void display() {
    println(filler);
    if (filler == 0) {
          tint(color_values.get("red"));
        }
        else if (filler == 1) {
          tint(color_values.get("orange"));
        }
        else if (filler == 2) {
          tint(color_values.get("yellow"));
        }
        else if (filler == 3) {
          tint(color_values.get("green"));
        }
        else if (filler == 4) {
          tint(color_values.get("light_blue"));
        }
        else if (filler == 5) {
          tint(color_values.get("dark_blue"));
        }
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
    float distance = sqrt((distX*distX) + (distY*distY) );

    // if the distance is less than the radius, collision!
    if (distance <= eneR) {
      return true;
    }
    return false;
  }

  void checkHealth(Car e) {
    if (overEnemy(e.r.x, e.r.y, e.carWidth, critter.xpos, critter.ypos, dino.width-190, dino.height-190)) {
      print("game over");
    }
  }
  // combined functions to make a simple call for the entire Dino to fly
  void FlyForward() {
    if (filler == 0) {
          tint(color_values.get("red"));
        }
        else if (filler == 1) {
          tint(color_values.get("orange"));
        }
        else if (filler == 2) {
          tint(color_values.get("yellow"));
        }
        else if (filler == 3) {
          tint(color_values.get("green"));
        }
        else if (filler == 4) {
          tint(color_values.get("light_blue"));
        }
        else if (filler == 5) {
          tint(color_values.get("dark_blue"));
        }
    critter.display();
    flapper.bounce(1, 1);
    flapper.display();
    swiper.bounce(1, 1);
    swiper.display();
  }
}
