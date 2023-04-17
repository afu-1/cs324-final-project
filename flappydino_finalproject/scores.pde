//Annie
class Scores {
  Table scores;
  int total_rows;
  
  Scores(Table scores){
    this.scores = scores;
  }
  
  //creates a new row to add into csv file
  void set_score(String name, int score){
    TableRow newRow = scores.addRow();
    newRow.setString("name", name);
    newRow.setInt("score", score * -1); //note to self: remember to multiply score by -1 to reverse the order in greatest to least
    noLoop(); //prevents draw loop from making all 5 values be the most recent value
  }
  
  void display(){
    //display header
    fill(93, 155, 155);
    text("Name", width/2 - 100, height/2 - 60);
    text("Score", width/2 + 30, height/2 -  60);
    
    //determines the number of rows to be displayed (whether it's 5 or less than 5)
    if (scores.getRowCount() < 5){
      total_rows = scores.getRowCount();
    } else {
      total_rows = 5;
    }
    
    //display scores
    fill(132, 195, 190);
    
    scores.sort("score"); //sorts them from least to greatest in value (greatest magnitude to least magnitude)
    
    //display top 5 scores
    for (int i = 1; i < total_rows + 1; i++){
      TableRow row = scores.getRow(i - 1);
      text(row.getString("name"), width/2 - 100, height/2 - 60 + 30*i);
      text(row.getInt("score") * -1, width/2 + 30, height/2 - 60 + 30* i); //remember to multiply by -1 to put scores back in positive
    }
  }
}
