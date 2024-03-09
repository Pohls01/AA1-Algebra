//int getNum(char c){
//  int tempNum = 0;
//  c = keyPressed;
//  if (keyChecker(c)=="NUM"){
    
//  }
//}

Button startButton;

void setupInputs(){
  
  startButton = new Button();
  startButton.x = width/2;
  startButton.y = height/2+150;
  startButton.sizeX = 350;
  startButton.sizeY = 80;
  startButton.butText = "START GAME";
  startButton.hiTextCol = 0;
}
void keyPressed(){
  if (inStart){
    if (keyChecker(key) == "NUM"){
      N = (N * 10) + (int(key) - '0');
      if(N>100){N = 100;}
    }
    if (key == BACKSPACE){
      N /= 10;
    }
  }
}
void mousePressed(){
  if (inStart){
    if(startButton.overButton()){
      inStart = false;
    }
  }
}

class Button{
  color butCol = 0;
  color highlightCol = 155;
  int x;
  int y;
  int sizeX;
  int sizeY;
  int cornerRadius = 15;
  
  String butText;
  color textCol = 255;
  color hiTextCol = 0;
  int txtSize = 50;
  
  boolean overButton(){
    if (mouseX >= x-sizeX/2 && mouseX <= x+sizeX/2 && 
        mouseY >= y-sizeY/2 && mouseY <= y+sizeY/2) {
      return true;
    } 
    else {
     return false;
    }
  }
  
  void drawButton(){
    color tempTextCol;
    rectMode(CENTER);
    if (overButton()) {
      fill(butCol);
      rect(x, y, sizeX+10, sizeY+10, 20);
      fill(highlightCol);
      tempTextCol = hiTextCol;
    }
    else {
      fill(butCol);
      tempTextCol = textCol;
    }
    stroke(255);
    rect(x, y, sizeX, sizeY, 15);
    if (butText != null && !butText.isEmpty()){
      textSize(txtSize);
      textAlign(CENTER, CENTER);
      fill(tempTextCol);
      text(butText, x, y);
    }
  }
}
String keyChecker(char c){
  if (c >= '0' && c <= '9'){
    return "NUM";
  }
  else if ((c>='A' && c<='Z') || (c >= 'a' && c <= 'z')){
    return "LET";
  }
  else {
    return "OTH";
  }
}
