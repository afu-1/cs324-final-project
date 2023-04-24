//Anthony
class Button {
  PVector org;
  int lenx;
  int leny;
  color col;
  int filler;
  
  Button (int x, int y, int lengthx, int lengthy, int c1, int c2, int c3, int filler) {
    this.org = new PVector(x,y);
    this.lenx = lengthx;
    this.leny = lengthy;
    this.col = color(c1,c2,c3);
    this.filler = filler;
  }
  
  void display() {
    fill (this.col);
    rect(this.org.x, this.org.y, this.lenx, this.leny);
  }
  
  boolean isOver() {
    if ((mouseX+50 >= this.org.x) && (mouseX+50 <= (this.org.x + this.lenx))){
      if ((mouseY +100 >= this.org.y) && (mouseY +100 <= (this.org.y + this.leny))){
        //println("isOver");
        return true;
      }
    }
    return false;
  }
}
