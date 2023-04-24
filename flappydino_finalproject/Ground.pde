//Jose
class Ground {
  // A Ground class.
  
  color groundColor; // color of the ground
  float groundWidth; // width of the ground
  float groundHeight; // height of the ground
  
  Ground(color groundColor, float groundWidth, float groundHeight) {
    // Constructor.
    
    this.groundColor = groundColor;
    this.groundWidth = groundWidth;
    this.groundHeight = groundHeight;
    
  }
  
  void display() {
    // Displays the ground.
    
    stroke(this.groundColor);
    fill(this.groundColor);
    rectMode(CORNER);
    rect(0, height - this.groundHeight, this.groundWidth, this.groundHeight);
    stroke(0);
  }
}
