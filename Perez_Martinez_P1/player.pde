class Player{
  PVector position;
  float mouseDelay = 0.8;
  float playerSpeed = 7.5;
  PVector direction = new PVector(0,0);
  float anglePlayer;
  PVector min_pc;
  PVector max_pc;
  float playerSize = 15;
  int playerQuadrant;
  boolean colliding = false;
  void move(){
    
    PVector tempPos = new PVector(position.x,position.y);
    playerQuadrant = getQuadrant(position);
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
      
      //text(direction.x, width/2-100, 900);
      //text(direction.y, width/2+100, 900);
       
       direction.normalize();
       
        tempPos.x += direction.x * playerSpeed;
        tempPos.y += direction.y * playerSpeed;
      }  
       if(mouseCommandActivated){
         direction.x = mouseX - tempPos.x;
         direction.y = mouseY - tempPos.y;
         
         direction.normalize();
           tempPos.x += direction.x * playerSpeed;
           tempPos.y += direction.y * playerSpeed;
      }
      if(tempPos != position){
        if (!calculateCollisions(tempPos)){
          colliding = true;
          position.x = constrain (tempPos.x, 5, width-5);
          position.y = constrain (tempPos.y, 5, height-5);
        }
      }
    }
    boolean calculateCollisions(PVector pos){
      // Evaluate collisions
      boolean tempBool = false;
      min_pc.x = pos.x-playerSize;
      min_pc.y = pos.y-playerSize;
      max_pc.x = pos.x+playerSize;    
      max_pc.y = pos.y+playerSize;
      for(int i = 0; i<amountCircleObstacles;i++){
        if(circleObstacles[i].obsQuadrant == getQuadrant(pos)){
          if(sqrt(pow(circleObstacles[i].position.x-pos.x,2) + pow(circleObstacles[i].position.y-pos.y,2)) <= circleObstacles[i].size.x + player.playerSize){
            tempBool = true;
          }
        }
      }
      for(int i = 0; i<amountRectObstacles;i++){
        if(rectObstacles[i].obsQuadrant == getQuadrant(pos)){
          if(!((max_pc.x<rectObstacles[i].min_obs.x)||(max_pc.y<rectObstacles[i].min_obs.y) || (rectObstacles[i].max_obs.x<min_pc.x)||(rectObstacles[i].max_obs.y<min_pc.y))){
            tempBool = true;
          }
        }
      }
      return tempBool;
  }  
}

Player InitializePlayer(){
  Player tempPlayer = new Player();
  tempPlayer.position = new PVector(mouseX, mouseY);
  tempPlayer.playerQuadrant = getQuadrant(tempPlayer.position);
  tempPlayer.min_pc = new PVector (tempPlayer.position.x-tempPlayer.playerSize,tempPlayer.position.y-tempPlayer.playerSize);
  tempPlayer.max_pc = new PVector (tempPlayer.position.x+tempPlayer.playerSize,tempPlayer.position.y+tempPlayer.playerSize);  
  return tempPlayer;
}
