class Player{
  float x;
  float y;
  float mouseDelay = 0.7;
  void move(){
    x = (mouseDelay) * x + (1-mouseDelay) * mouseX;
    y = (mouseDelay) * y + (1-mouseDelay) * mouseY;
  }
}

Player InitializePlayer(){
  Player tempPlayer = new Player();
  tempPlayer.x = mouseX;
  tempPlayer.y = mouseY;
  
  return tempPlayer;
}
