class Player{
  float x;
  float y;
  float mouseDelay = 0.7;
  float playerSpeed = 7.5;
  PVector direction = new PVector(0,0);
  float anglePlayer;
  
  void move(){
    
    //Cambio de los comandos según el booleano
    
if(!mouseCommandActivated){
  
  if ((keyUp && keyDown) || (!keyUp && !keyDown))
  direction.y = 0;
  else if (keyUp)
  direction.y = -1;
  else if (keyDown)
  direction.y = 1;
  
  if ((keyLeft && keyRight) || (!keyLeft && !keyRight))
  direction.x = 0;
  else if (keyLeft)
  direction.x = -1;
  else if (keyRight)
  direction.x = 1;
  
  text(direction.x, width/2-100, 900);
  text(direction.y, width/2+100, 900);
   
   direction.normalize();
   
    x += direction.x * playerSpeed;
    y += direction.y * playerSpeed;
}  
   if(mouseCommandActivated){
    x = (mouseDelay) * x + (1-mouseDelay) * mouseX;
    y = (mouseDelay) * y + (1-mouseDelay) * mouseY;
  }
  x = constrain (x, 5, width-5);
  y = constrain (y, 5, height-5);
}
}

Player InitializePlayer(){
  Player tempPlayer = new Player();
  tempPlayer.x = mouseX;
  tempPlayer.y = mouseY;
  
  return tempPlayer;
}
