//Variables
boolean playerCollisionPU;
powerUp activePowerUp;
int powerUpCount = 0;
int lastPowerUp = 0;
boolean checkingTime = false;


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
        vidas ++;
        description = "Life Up!";
        
    }
    
    void PowerUpMoreTime() {
        timeLeft += 60;
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
    void ResetPowerUp() {
        player.playerSpeed = 10;
        npc1.speed = 9;
        npc2.speed = 9;
        enemySpeed = 2.5;
        description = "";
    }
    
    //Función para obtener un power up aleatorio
    void GenerateRandomPowerUP() {
        int powerUp = (int)random(1, 7);
        ResetPowerUp();
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
        powerUpCount++;
        lastPowerUp = millis();
        checkingTime = true;
        position.x = -200;
    }
    
    void drawPowerUp() {  
        if (!checkingTime) {
            //for (int counter = 0; counter < 5; counter++){
            stroke(153);
            strokeWeight(4);
            fill(colorPU);
            rect(position.x, position.y, size.x, size.y); 
        }
        else{
            if (millis() - duration * 1000>lastPowerUp) {
                checkingTime = false;
                ResetPowerUp();
                position = new PVector(random(100,width - 100), random(100,height - 100));
                size = new PVector(random(20, 80), random(20, 80));
                colorPU = color(random(256), random(256), random(256));
            }
        }
    }
}


powerUp InitializePowerUp() {
    powerUp myPowerUp = new powerUp();
    myPowerUp.position = new PVector(random(100,width - 100), random(100,height - 100));
    myPowerUp.size = new PVector(random(20, 80), random(20, 80));
    myPowerUp.colorPU = color(random(256), random(256), random(256));
    return myPowerUp;
}

//void displayPowerUp(String description){

//  text(description, width-200, height-100);
  //}
