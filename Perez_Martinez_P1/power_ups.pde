//Variables
boolean playerCollisionPU;

class powerUP{
  float x;
  float y;

  void PowerUpAumentoVelocidad(){
     player.mouseDelay = 0.2;
  }
  
  void PowerUpSlowEnemies(){
  enemySpeed = 1;
  }
  
  void PoweUpExtraLife(){
  vidas +=1;
  }
  
  void PowerUpMoreTime(){
  currentTime += 60*1000;
  }
  
  void PowerUpRestoreLifePNJ(){
  salud +=50; //VALOR TEMPORAL
  }
  
  void PowerUpFreezeEnemies(){
  enemySpeed = 0;
  }
}

void 
