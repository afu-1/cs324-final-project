//Anthony
class GetInput {
  String typing;
  String inputStr;
  
  GetInput() {
    this.typing = "";
    this.inputStr = "";
  }
  
  void keyPressed(){
  if (key != BACKSPACE){
    this.typing += key;
  } else if (key == BACKSPACE){
      this.typing = this.typing.substring(0, max(0, this.typing.length() - 1)); //implement backspace function for input
  }
    this.inputStr = this.typing;
  }
}
    
