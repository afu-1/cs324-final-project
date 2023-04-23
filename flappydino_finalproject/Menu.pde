//Anthony
class Menu {
  Button b1;
  Button b2;
  Button b3;
  Button b4;
  Button b5;
  Button b6;
  Dino b1Dino;
  Dino b2Dino;
  Dino b3Dino; 
  Dino b4Dino; 
  Dino b5Dino; 
  Dino b6Dino;
  int mode;
  PFont font;
  boolean mainOn;
  boolean endOn;
  ArrayList<Button> buttons;
  ArrayList<Dino> dinos;

  Menu () {
    this.buttons = new ArrayList<Button>();
    this.mainOn = true;
    this.endOn = false;
    this.dinos = new ArrayList<Dino>();
  }

  void mainMenu () {
    //Create font
    font = createFont("PressStart2P-Regular.ttf", 128);
    if (this.mainOn) {
      for (int i = 0; i < 6; i++) {
        Button b = buttons.get(i);
        b.display();
      }
      for (int i = 0; i < 6; i++) {
        Dino d = dinos.get(i);
        d.FlyForward();
      }

      fill(155);
      textFont(font);
      // display previous highscore
      // display controls
      // display buttons for the colors
      textSize(32);
      text("Welcome to FlappyDino", 150, 200);
    } else if (this.endOn) {
      fill(255);
      rectMode(CORNERS);
      rect(-50, -50, 1050, 850);
      fill(150);
      text("Game Over", 250, 400);
    } else {
      return;
    }
  }

  void createButtons() {
    b1 = new Button(57, 500, 100, 200, 255, 89, 94);
    b2 = new Button(214, 500, 100, 200, 255, 146, 76);
    b3 = new Button(371, 500, 100, 200, 255, 202, 58);
    b4 = new Button(528, 500, 100, 200, 82, 166, 117);
    b5 = new Button(685, 500, 100, 200, 25, 130, 196);
    b6 = new Button(842, 500, 100, 200, 66, 103, 172);
    buttons.add(b1);
    buttons.add(b2);
    buttons.add(b3);
    buttons.add(b4);
    buttons.add(b5);
    buttons.add(b6);
  }

  void createDinos() {
    b1Dino = new Dino(10, 500, 0, 0, 0);
    b2Dino = new Dino(167, 500, 0, 0, 0);
    b3Dino = new Dino(324, 500, 0, 0, 0);
    b4Dino = new Dino(481, 500, 0, 0, 0);
    b5Dino = new Dino(638, 500, 0, 0, 0);
    b6Dino = new Dino(795, 500, 0, 0, 0);
    dinos.add(b1Dino);
    dinos.add(b2Dino);
    dinos.add(b3Dino);
    dinos.add(b4Dino);
    dinos.add(b5Dino);
    dinos.add(b6Dino);
  }
}
