Car[] carArray; // array of obstacles

float carHeight;
float carWidth;

void setup() {

  size(1000, 1000, P3D);
  frameRate(60);

  // Fixed car width and height
  carWidth = width / 10;
  carHeight = height / 10;

  // Initalize car array
  int numOfCars = 3; // the number of obstacles at a time
  carArray = new Car[numOfCars];

  // Obstacles will come in from the right
  for (int i = 0; i < carArray.length; i++) {

    // Create cars (spawn on right side)
    float x = width; // right side
    float y = random(carHeight / 2, height - carHeight / 2 + 1);
    float vx = -random(1, 6);
    float vy = 0;
    float scale = 1;
    Car c = new Car(x, y, vx, vy, scale, width/10, height/10);

    // Put into array
    carArray[i] = c;
  }
}

void draw() {

  // Lighting and background
  lights();
  background(0);

  // Display all particles
  for (int i = 0; i < carArray.length; i++) {
    carArray[i].display();
  }

  // Move all particles
  for (int i = 0; i < carArray.length; i++) {
    carArray[i].move();
  }
  
  // Respawn cars that havge gone off-screen (cars that started on the right)
  for (int i = 0; i < carArray.length; i++) {
    
    // Check for cars that have gone out of bounds
    if (carArray[i].isOutOfBounds()) {

      // New parameters
      float x = width;
      float y = random(carArray[i].carHeight / 2, height - carArray[i].carHeight / 2 + 1);
      float vx = -random(1, 6);
      float vy = 0;
      float scale = 1;

      // Respawn the car
      carArray[i].respawn(x, y, vx, vy, scale);
    }
  }
}
  
