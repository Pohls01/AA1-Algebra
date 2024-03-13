//Variables
boolean playerCollisionPU;
powerUp activePowerUp;

class powerUp{
  PVector position;
  PVector size;
  color colorPU;

    void PowerUpAumentoVelocidad(){
       player.mouseDelay = 0.2;
    }
    
    void PowerUpSlowEnemies(){
    enemySpeed = 1;
    }
    
    void PowerUpExtraLife(){
    vidas +=1;
    }
    
    void PowerUpMoreTime(){
    currentTime += 60*1000;
    }
    
    void PowerUpRestoreLifePNJ(){
    salud +=50; 
    }
    
    void PowerUpFreezeEnemies(){
    enemySpeed = 0;
    }
  
    //Función para obtener un power up aleatorio
    void GenerateRandomPowerUP(){
    int powerUp = (int)random(1, 7);
    
    switch(powerUp){
      case 1: PowerUpAumentoVelocidad();
      
      case 2:PowerUpSlowEnemies();
      
      case 3: PowerUpExtraLife();
      
      case 4: PowerUpMoreTime();
      
      case 5: PowerUpRestoreLifePNJ();
      
      case 6: PowerUpFreezeEnemies();
    
      }  
      
    }
    
    void drawPowerUp(){  
    //for (int counter = 0; counter < 5; counter++){
    
    stroke(153);
    strokeWeight(4);
    fill(colorPU);
    rect(position.x, position.y, size.x, size.y); 
    
    
  }
     }
  
  powerUp InitializePowerUp(){
  powerUp myPowerUp = new powerUp();
    myPowerUp.position = new PVector(random(width), random(height));
    myPowerUp.size = new PVector(random(20, 80), random(20, 80));
    myPowerUp.colorPU = color (random(256), random(256), random(256));
  return myPowerUp;
  }
  
  
 
