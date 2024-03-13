boolean bulletActive = false; 


class Player{
  PVector position;
  float mouseDelay = 0.7;
  float playerSpeed = 12;
  PVector direction = new PVector(0,0);
  float anglePlayer;
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
         if(sqrt(pow(direction.x,2) + pow(direction.y,2)) >= followThreshold){
         direction.normalize();
         tempPos.x += direction.x * playerSpeed;
         tempPos.y += direction.y * playerSpeed;
       }
     }
     if (!calculateCollisions(tempPos, playerSize)){
       position.x = constrain (tempPos.x, 5, width-5);
       position.y = constrain (tempPos.y, 5, height-5);
     }
   }
   

 }  

Player InitializePlayer(){
  Player tempPlayer = new Player();
  do{
  tempPlayer.position = new PVector(random(width), random(height));
  } while(calculateCollisions(tempPlayer.position, tempPlayer.playerSize));
  tempPlayer.playerQuadrant = getQuadrant(tempPlayer.position);
  return tempPlayer;
}

class Bullet{
PVector bulletPos;
int bulletSpeed = 3;

   //Posible manera de cargarse al Boss
   void initializeBullets(){
   Bullet myBullet = new Bullet();
   myBullet.bulletPos = new PVector(player.position.x , player.position.y );
   myBullet.bulletSpeed= 3;
   
   }

}
   
   void playerShoot(){
    Bullet myBullet = new Bullet();
 myBullet.bulletPos.x=player.direction.x*myBullet.bulletSpeed;
       fill(0, 255, 0);
       ellipse(myBullet.bulletPos.x, myBullet.bulletPos.y, 20, 20);
      
   
   }
