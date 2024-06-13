boolean bulletActive = false; 


class Player{
    PVector position;
    PVector direction = new PVector(0,0);
    float mouseDelay = 0.7;
    float playerSpeed = 10;
    float anglePlayer;
    float playerSize = 15;
    int playerQuadrant;
    boolean colliding = false;
    int score = 0; 

   
    //Función para cazar enemigos
    void eatEnemies() {
        for (int i = pEnemies.size() - 1; i >= 0; i--) {
            PassiveEnemy enemy = pEnemies.get(i);
            if (collideEntities(position, playerSize, enemy.position, enemy.enemyColSize)) {
                pEnemies.remove(i);
                //Aumento de score por cada enemigo cazado
                score += 1;
            }
        }
        for (int i = cEnemies.size() - 1; i >= 0; i--) {
            ChasingEnemy enemy = cEnemies.get(i);
            if (collideEntities(position, playerSize, enemy.position, enemy.enemyColSize)) {
                cEnemies.remove(i);
                //Aumento de score por cada enemigo cazado
                score += 1;
            }
        }
    }
    
    void move() {
        
        if (allNPCsCollected && collideEntities(position, playerSize,activePowerUp.position, activePowerUp.size.x)) {
            activePowerUp.GenerateRandomPowerUP();
            //Aumento de score por cada power up recogido
            score += 100;
        }
        
        PVector tempPos = new PVector(position.x,position.y);
        playerQuadrant = getQuadrant(position);
        //Cambio de los comandos según el booleano
        
        if (!mouseCommandActivated) {
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
        if (mouseCommandActivated) {
            direction.x = mouseX - tempPos.x;
            direction.y = mouseY - tempPos.y;
            if (sqrt(pow(direction.x,2) + pow(direction.y,2)) >= followThreshold) {
                direction.normalize();
                tempPos.x += direction.x * playerSpeed;
                tempPos.y += direction.y * playerSpeed;
            }
        }
        if (!calculateCollisions(tempPos, playerSize)) {
            position.x = constrain(tempPos.x, 5, width - 5);
            position.y = constrain(tempPos.y, 5, height - 5);
        }

        eatEnemies();
    }
    
    
}  

Player InitializePlayer() {
    Player tempPlayer = new Player();
    do{
        tempPlayer.position = new PVector(random(width), random(height));
    } while(calculateCollisions(tempPlayer.position, tempPlayer.playerSize));
    tempPlayer.playerQuadrant = getQuadrant(tempPlayer.position);
    return tempPlayer;
}
