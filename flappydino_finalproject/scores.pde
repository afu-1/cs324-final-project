//Annie
class Scores {
  Table scores;
  int total_rows;
  
  Scores(Table scores){
    this.scores = scores;
  }
  
  void display(){
    fill(93, 155, 155); //sets color of header row
    text("Name", width/2 - 100, height/2 - 60);
    text("Score", width/2 + 30, height/2 -  60);
    fill(132, 195, 190); //sets color of actual data
    
    if (scores.getRowCount() < 5){
      total_rows = scores.getRowCount();
    } else {
      total_rows = 5;
    }
    
    
    //display top 5 scores
    for (int i = 1; i < total_rows + 1; i++){
      TableRow row = scores.getRow(i - 1);
      text(row.getString("name"), width/2 - 100, height/2 - 60 + 30*i);
      text(row.getInt("score") * -1, width/2 + 30, height/2 - 60 + 30* i); //remember to multiply by -1 to put scores back in positive
    }
  }
}
