import java.util.Map;

//classes
Scores score_sheet;

//global objects
JSONArray colors;
HashMap<String, Integer> color_values = new HashMap<String, Integer> ();

PImage sprite;
Table scores;
PFont game_font;

void setup(){
  //feel free to change
  size(500, 500);
  
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
  game_font = createFont("Butterbean.otf", 30);
  textFont(game_font);
  
  //scores sheet - Annie
  scores = new Table();
  scores.addColumn("name", Table.STRING);
  scores.addColumn("score", Table.INT);
  
  //will change with input values instead of just random test values - Annie
  for(int i = 0; i < 5; i++){
    TableRow newRow = scores.addRow();
    newRow.setString("name", "test");
    newRow.setInt("score", i * 300 * -1); //note to self: remember to multiply score by -1 to reverse the order in greatest to least
  }
  
  saveTable(scores, "scores.csv"); //creates new table
  
  scores.sort("score"); //sorts them from least to greatest in value (greatest magnitude to least magnitude)
  score_sheet = new Scores(scores); //sends new scores into scores class
}

void draw(){
  background(0);
  
  //displays the scores sheet (feel free to comment out)- Annie
  score_sheet.display();
  
  //displays all of the colors of the sprite (feel free to remove) - Annie
  //red
  tint(color_values.get("red"));
  image(sprite, 0, 0);
  
  //orange
  tint(color_values.get("orange"));
  image(sprite, 150, 0);
  
  //yellow
  tint(color_values.get("yellow"));
  image(sprite, 300, 0);
  
  //green
  tint(color_values.get("green"));
  image(sprite, 0, 150);

  //light blue
  tint(color_values.get("light_blue"));
  image(sprite, 150, 150);
  
  //dark blue
  tint(color_values.get("dark_blue"));
  image(sprite, 300, 150);
  
  //purple
  tint(color_values.get("purple"));
  image(sprite, 0, 300);
  
  //white
  tint(color_values.get("white"));
  image(sprite, 300, 300);
  
}
