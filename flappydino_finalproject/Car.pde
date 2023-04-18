class Car {

  PVector r; // particle's position vector
  PVector v; // particle's velocity vector
  float scale; // particle's scale factor to multiply shape
  float carWidth; // particle's width
  float carHeight; // particle's height


  Car(float x, float y, float vx, float vy, float scale, float carWidth, float carHeight) {
    // Particle class constructor.

    this.r = new PVector(x, y);
    this.v = new PVector(vx, vy);
    this.scale = scale;
    this.carWidth = carWidth;
    this.carHeight = carHeight;
    
  }

  void move() {
    // Moves the particle.

    this.r.x += this.v.x;
    this.r.y += this.v.y;
  }

  void display() {
    // Displays the particle.
    
    rectMode(CENTER);
    rect(this.r.x, this.r.y, this.carWidth * this.scale, this.carHeight * this.scale);
    
  }
  
  Boolean isOutOfBounds() {
    // Checks whether a car has gone off screen.
    
    if (this.r.x < 0 || this.r.x > width || this.r.y < 0 || this.r.y > height) {
      return true;
    } else {
      return false;
    }
  }
    

  void respawn(float x, float y, float vx, float vy, float scale) {
    // If the the particle falls into a singularity, it will respawn it with new attribute values. All parameters signify the new attribute values the respawned particle will take on.

    if (this.isOutOfBounds()) {

      this.r = new PVector(x, y);
      this.v = new PVector(vx, vy);
      this.scale = scale;
      
    }
  }
}
