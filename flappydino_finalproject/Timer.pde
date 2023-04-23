//Anthony
class Timer {
  int time;
  int startTime;
  int pauseTime;
  boolean pause;
  boolean started;
  
  Timer () {
    this.time = 0;
    this.startTime = 0;
    this.pause = false;
    this.pauseTime = 0;
    this.started = false;
  }
  
  void display() {
    if (this.started) {//create font
    PFont font;
    PFont fontPause;
    font = createFont("PressStart2P-Regular.ttf", 20);
    fontPause = createFont("PressStart2P-Regular.ttf", 60);
    // draw the box for the timer
    strokeWeight(4);
    fill(4, 142, 183);
    rectMode(CORNER);
    rect(800,0,200,75);
    if (this.pause == false){
      updateTime();
    }
    
    else {
      fill(255);
      rectMode(CORNERS);
      //rect(-50,-50,1050,850);
      fill(0);
      textFont(fontPause);
      text("Pause", 300,500);
      this.pauseTime =  (millis() - this.time*1000 - this.startTime);
      //println(this.pauseTime);
    }
    
    
    fill(200);
    textFont(font);
    text( "Time: " + str(this.time), 810,50);
  }
  }
  
  void startTime() {
    this.startTime = millis();
    this.started = true;
  }
  
  void updateTime() {
    //println(this.startTime);
    this.time = (millis() - this.pauseTime - this.startTime)/1000;
  }
  
  void pauseTime() {
    if (this.pause) {
      this.pause = false;
    }
    else {
      this.pause = true;
    }
  }
  
}
    
    
