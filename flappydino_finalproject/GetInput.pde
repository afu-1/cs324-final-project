class GetInput {
  String typing;
  String inputStr;
  
  GetInput() {
    this.typing = "";
    this.inputStr = "";
  }
  
  void keyPressed(){
    this.typing += key;
    this.inputStr = this.typing;
  }
}
    
