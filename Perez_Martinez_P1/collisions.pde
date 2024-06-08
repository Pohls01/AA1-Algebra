
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

Obstacle InitCircleObstacle() {
    Obstacle tempCircle = new Obstacle();
    tempCircle.isCircle = true;
    tempCircle.position = new PVector(random(width), random(height));
    tempCircle.size = new PVector(20,20);
    tempCircle.obsQuadrant = getQuadrant(tempCircle.position);
    return tempCircle;
}
Obstacle InitRectObstacle() {
    Obstacle tempRect = new Obstacle();
    tempRect.isCircle = false;
    tempRect.position = new PVector(random(width), random(height));
    tempRect.size = new PVector(60,20);
    tempRect.min_obs = new PVector(tempRect.position.x - tempRect.size.x / 2, tempRect.position.y - tempRect.size.y / 2); 
    tempRect.max_obs = new PVector(tempRect.position.x + tempRect.size.x / 2, tempRect.position.y + tempRect.size.y / 2); 
    tempRect.obsQuadrant = getQuadrant(tempRect.position);  
    return tempRect;
}
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
        ellipse(circleObstacles[i].position.x, circleObstacles[i].position.y, circleObstacles[i].size.x, circleObstacles[i].size.x);
        }
    
    // drawing the rectangular obstacles
    fill(0, 0, 255);
    for (int i = 0; i < rectObstacles.length; i++) {
        strokeWeight(0);
        rect(rectObstacles[i].position.x, rectObstacles[i].position.y, rectObstacles[i].size.x, rectObstacles[i].size.y);
        }
    }
