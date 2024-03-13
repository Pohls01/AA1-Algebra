//Variables
boolean playerCollisionPU;
powerUp activePowerUp;
int powerUpCount = 0;
int lastPowerUp = 0;


class powerUp{
    PVector position;
    PVector size;
    color colorPU;
    String description = "";
    int duration = 10;
    
    void PowerUpAumentoVelocidad() {
        player.playerSpeed *= 1.5;
        npc1.speed *= 1.5;
        npc2.speed *= 1.5;
        description = "Speed Up!";
        
    }
    
    void PowerUpSlowEnemies() {
        enemySpeed = 1;
        description = "Enemy speed Down!";
    }
    
    void PowerUpExtraLife() {
        vidas += 1;
        description = "Life Up!";
        
    }
    
    void PowerUpMoreTime() {
        currentTime += 60 * 1000;
        description = "Extra Time!";
        
    }
    
    void PowerUpRestoreLifePNJ() {
        salud += 50; 
        description = "HP Up!";
        
    }
    
    void PowerUpFreezeEnemies() {
        enemySpeed = 0;
        description = "Enemies Frozen!";
        
    }
    
    //Función para obtener un power up aleatorio
    void GenerateRandomPowerUP() {
        int powerUp = (int)random(1, 7);
        
        switch(powerUp) {
            case 1 : PowerUpAumentoVelocidad();
                break;
            case 2 : PowerUpSlowEnemies();
                break;
            case 3 : PowerUpExtraLife();
                break;
            case 4 : PowerUpMoreTime();
                break;
            case 5 : PowerUpRestoreLifePNJ();
                break;
            case 6 : PowerUpFreezeEnemies();
                break;
            
        }  
        
    }
    
    void drawPowerUp() {  
        //for (int counter = 0; counter < 5; counter++){
        
        stroke(153);
        strokeWeight(4);
        fill(colorPU);
        rect(position.x, position.y, size.x, size.y); 
        
        
    }
}


powerUp InitializePowerUp() {
    powerUp myPowerUp = new powerUp();
    myPowerUp.position = new PVector(random(width), random(height));
    myPowerUp.size = new PVector(random(20, 80), random(20, 80));
    myPowerUp.colorPU = color(random(256), random(256), random(256));
    return myPowerUp;
}

//void displayPowerUp(String description){

//  text(description, width-200, height-100);
  //}


