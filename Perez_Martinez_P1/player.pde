class Player{
  float x;
  float y;
  float mouseDelay = 0.7;
  
  void move(){
    
    //Cambio de los comandos según el booleano
    
if(!mouseCommandActivated){
   if(keyPressed){
    if (key=='w' || key=='W')
      y-=10;
   if (key=='a' || key=='A')
      x-=10;
   if (key=='s' || key=='S')
      y+=10;
   if (key=='d' || key=='D')
      x+=10;    
    }
}  
   
   if(mouseCommandActivated){ 
    x = (mouseDelay) * x + (1-mouseDelay) * mouseX;
    y = (mouseDelay) * y + (1-mouseDelay) * mouseY;
  }
}
}

Player InitializePlayer(){
  Player tempPlayer = new Player();
  tempPlayer.x = mouseX;
  tempPlayer.y = mouseY;
  
  return tempPlayer;
}
