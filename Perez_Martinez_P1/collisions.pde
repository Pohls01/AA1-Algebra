
//VARIABLES
//Arrays for the obstacle Collisions
Obstacle[] circleObstacles;
Obstacle[] rectObstacles;



int amountCircleObstacles = 8; //Amount of circle obstacles in the scene
int amountRectObstacles = 7; //Amount of rectangle obstacles in the scene

class Obstacle{
    boolean isCircle;
    
    PVector position;
    PVector size;
    PVector min_obs;
    PVector max_obs;
    int obsQuadrant;
}


//PARA EVITAR QUE LOS OBSTACULOS SE SUPERPONGAN

Obstacle InitCircleObstacle() {
    Obstacle tempCircle = new Obstacle();
    tempCircle.isCircle = true;
    tempCircle.size = new PVector(20,20);
    do {
        tempCircle.position = new PVector(random(windowMargin, width - windowMargin), random(windowMargin, height - windowMargin));
    } while (isCollidingWithAnyObstacle(tempCircle));
    tempCircle.obsQuadrant = getQuadrant(tempCircle.position);
    return tempCircle;
}

Obstacle InitRectObstacle() {
    Obstacle tempRect = new Obstacle();
    tempRect.isCircle = false;
    tempRect.size = new PVector(60,20);
    do {
        tempRect.position = new PVector(random(windowMargin, width - windowMargin), random(windowMargin, height - windowMargin));
    } while (isCollidingWithAnyObstacle(tempRect));
    tempRect.min_obs = new PVector(tempRect.position.x - tempRect.size.x / 2, tempRect.position.y - tempRect.size.y / 2); 
    tempRect.max_obs = new PVector(tempRect.position.x + tempRect.size.x / 2, tempRect.position.y + tempRect.size.y / 2); 
    tempRect.obsQuadrant = getQuadrant(tempRect.position);  
    return tempRect;
}

boolean isCollidingWithAnyObstacle(Obstacle newObstacle) {
    for (Obstacle obstacle : circleObstacles) {
        if (obstacle != null && collideEntities(newObstacle.position, newObstacle.size.x + 75, obstacle.position, obstacle.size.x)) {
            return true;
        }
    }
    for (Obstacle obstacle : rectObstacles) {
        if (obstacle != null && collideEntities(newObstacle.position, newObstacle.size.x + 75, obstacle.position, obstacle.size.x)) {
            return true;
        }
    }
    return false;
}


// Obstacle InitCircleObstacle() {
//     Obstacle tempCircle = new Obstacle();
//     tempCircle.isCircle = true;
//     tempCircle.position = new PVector(random(width), random(height));
//     tempCircle.size = new PVector(20,20);
//     tempCircle.obsQuadrant = getQuadrant(tempCircle.position);
//     return tempCircle;
// }
// Obstacle InitRectObstacle() {
//     Obstacle tempRect = new Obstacle();
//     tempRect.isCircle = false;
//     tempRect.position = new PVector(random(width), random(height));
//     tempRect.size = new PVector(60,20);
//     tempRect.min_obs = new PVector(tempRect.position.x - tempRect.size.x / 2, tempRect.position.y - tempRect.size.y / 2); 
//     tempRect.max_obs = new PVector(tempRect.position.x + tempRect.size.x / 2, tempRect.position.y + tempRect.size.y / 2); 
//     tempRect.obsQuadrant = getQuadrant(tempRect.position);  
//     return tempRect;
// }


//SET UP
void InitializeObstaclesPosition() {
    //array inicialization for circular obstacles
    circleObstacles = new Obstacle[amountCircleObstacles];
    
    rectObstacles = new Obstacle[amountCircleObstacles];
    
    //Circular Obstacles are randomly located
    for (int i = 0; i < circleObstacles.length; i++) {
        circleObstacles[i] = InitCircleObstacle();
    }
    //Rectangular Obstacles are randomly located
    for (int i = 0; i < rectObstacles.length; i++) {
        rectObstacles[i] = InitRectObstacle();
    }
    }

//DRAW
void drawObstacles() {
    //drawing the circular obstacles
    rectMode(CENTER);
    fill(0, 255,0);
    for (int i = 0; i < circleObstacles.length; i++) {
        strokeWeight(0);
        image(circularobstacle, circleObstacles[i].position.x, circleObstacles[i].position.y);
        }
    
    // drawing the rectangular obstacles
    fill(#2F1B0F);
    for (int i = 0; i < rectObstacles.length; i++) {
        strokeWeight(0);
        rect(rectObstacles[i].position.x, rectObstacles[i].position.y, rectObstacles[i].size.x, rectObstacles[i].size.y);
        //image(rectobstacle, rectObstacles[i].position.x, rectObstacles[i].position.y);
    }
       
}
    
