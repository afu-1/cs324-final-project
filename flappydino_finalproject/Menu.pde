//Anthony
class Menu {
  Button b1;
  Button b2;
  Button b3;
  Button b4;
  Button b5;
  Button b6;
  int mode;
  PFont font;
  boolean mainOn;
  boolean endOn;
  ArrayList<Button> buttons;
  
  Menu () {
    this.buttons = new ArrayList<Button>();
    this.mainOn = true;
    this.endOn = false;
    
  }
  
  void mainMenu () {
    //Create font
    font = createFont("PressStart2P-Regular.ttf", 32);
    if (this.mainOn) {
    for (int i = 0; i < 6; i++) {
      Button b = buttons.get(i);
      b.display();
    }
    
    fill(155);
    textFont(font);
  // display previous highscore
  // display controls
  // display buttons for the colors
    text("Weclome to FlappyDino", 50, 200);
    }
    else if (this.endOn) {
      fill(255);
      rectMode(CORNERS);
      rect(-50,-50,1050,850);
      fill(150);
      text("Game Over",250,400);
      
    }
    else {
      return;
    }
    
}

  void createButtons() {
    b1 = new Button(57,500,100,200,38, 250, 38);
    b2 = new Button(214,500,100,200,38, 250, 38);
    b3 = new Button(371,500,100,200,38, 250, 38);
    b4 = new Button(528,500,100,200,38, 250, 38);
    b5 = new Button(685,500,100,200,38, 250, 38);
    b6 = new Button(842,500,100,200,38, 250, 38);
    buttons.add(b1);
    buttons.add(b2);
    buttons.add(b3);
    buttons.add(b4);
    buttons.add(b5);
    buttons.add(b6);
  }
  

}
