class Tree extends Car {
  // A Tree class.
  
  color leafColor; // color of the leaves of the tree
  color trunkColor; // color of the tree trunk
  
  Tree(float x, float y, float vx, float vy, float scale, float carWidth, float carHeight, color leafColor, color trunkColor) {
    // Constructor
    
    super(x, y, vx, vy, scale, carWidth, carHeight);
    this.leafColor = leafColor;
    this.trunkColor = trunkColor;
    
  }
  
  void display() {
    // Displays the tree.
    
    // Trunk; note: position vector corresponds to middle of trunk
    rectMode(CENTER);
    stroke(this.trunkColor);
    fill(this.trunkColor);
    rect(this.r.x, this.r.y, this.carWidth, 2 * this.carHeight);
    
    // Leaves
    stroke(this.leafColor);
    fill(this.leafColor);
    rect(this.r.x - this.carWidth, this.r.y - this.carHeight/2, this.carWidth, this.carHeight); // top left
    rect(this.r.x, this.r.y - this.carHeight * 1.5, this.carWidth, this.carHeight); // top
    rect(this.r.x + this.carWidth, this.r.y - this.carHeight/2, this.carWidth, this.carHeight); // top right
    
    stroke(0);
    rectMode(CORNER);
    
  }
}
