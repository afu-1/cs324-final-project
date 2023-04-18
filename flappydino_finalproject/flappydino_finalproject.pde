import java.util.Map;

//classes
Scores score_sheet;

//global objects
JSONArray colors;
HashMap<String, Integer> color_values = new HashMap<String, Integer> ();

PImage sprite;
Table scores;
PFont score_font;

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
  score_font = createFont("Butterbean.otf", 30);
  textFont(score_font);
  
  //scores sheet - Annie
  scores = new Table();
  scores.addColumn("name", Table.STRING);
  scores.addColumn("score", Table.INT);
  
  saveTable(scores, "scores.csv"); //creates new table
  
  //initialize classes
  score_sheet = new Scores(scores);
}

void draw(){
  background(0);
  
  //sets scores using score class - Annie (will remove this when input data is available)
  for (int i = 0; i < 5; i++){
    score_sheet.set_score(str(i), i * 300);
  }
  
  //displays the scores sheet (feel free to comment out)- Annie
  score_sheet.display();
  
}
