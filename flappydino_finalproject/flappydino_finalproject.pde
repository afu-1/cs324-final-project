import java.util.Map;

//classes
Scores score_sheet;
Car[] carArray; // array of obstacles

//global objects
JSONArray colors;
HashMap<String, Integer> color_values = new HashMap<String, Integer> ();

PImage sprite;
Table scores;
PFont score_font;

float carHeight;
float carWidth;

void setup(){
  
  size(1000, 1000);
  frameRate(60);
  
  //set colors of the sprite and load the sprite image - Annie
  colors = loadJSONArray("colors.json");
  sprite = loadImage("sprite.png");
  
  //set color hashmap values - Annie
  for (int i = 0; i < colors.size(); i++){
    JSONObject c = colors.getJSONObject(i);
    
    String key_input = c.getString("color");
    String red = c.getString("R");
    String green = c.getString("G");
    String blue = c.getString("B");
    
    color_values.put(key_input, color(int(red), int(green), int(blue)));
  }
  
  //sets score font and text - Annie
  score_font = createFont("Butterbean.otf", 30);
  textFont(score_font);
  
  //scores sheet - Annie
  scores = new Table();
  scores.addColumn("name", Table.STRING);
  scores.addColumn("score", Table.INT);
  
  saveTable(scores, "scores.csv"); //creates new table
  
  //initialize classes
  score_sheet = new Scores(scores);
  
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

void draw(){
  // Lighting and background
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
  
  //sets scores using score class - Annie (will remove this when input data is available)
  //for (int i = 0; i < 5; i++){
  //  score_sheet.set_score(str(i), i * 300);
  //}
  
  //displays the scores sheet (feel free to comment out)- Annie
  //score_sheet.display();
  
  //reference for color values
  //tint(color_values.get("red"));
  //image(sprite, 0, 0);
  
}
