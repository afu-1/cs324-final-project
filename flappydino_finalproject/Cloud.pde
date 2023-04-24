//Jose
class Cloud extends Car {
  // A Cloud class. A subclass of Cars.
  
  Cloud(float x, float y, float vx, float vy, float scale, float carWidth, float carHeight) {
    // Constructor.
    
    super(x, y, vx, vy, scale, carWidth, carHeight);
    
  }
  
  void display() {
    // Displays the cloud.
    
    stroke(255);
    fill(255);
    
    // Leftmost circles
    ellipse(this.r.x - 0.5 * this.carWidth/2, this.r.y, this.carWidth * this.scale, this.carHeight * this.scale);
    ellipse(this.r.x - 0.5 * this.carWidth/2, this.r.y - 0.5 * this.carHeight/2, this.carWidth * this.scale, this.carHeight * this.scale);
    
    // Center circles
    ellipse(this.r.x, this.r.y, this.carWidth * this.scale, this.carHeight * this.scale);
    ellipse(this.r.x, this.r.y - 0.5 * this.carHeight/2, this.carWidth * this.scale, this.carHeight * this.scale);
    
    // Right circle
    ellipse(this.r.x + 0.5 * this.carWidth/2, this.r.y, this.carWidth * this.scale, this.carHeight * this.scale);
    ellipse(this.r.x + 0.5 * this.carWidth/2, this.r.y - 0.5 * this.carHeight/2, this.carWidth * this.scale, this.carHeight * this.scale);
    
    stroke(0);
    
  }
  
}
