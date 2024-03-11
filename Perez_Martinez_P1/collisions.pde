
//VARIABLES
//Arrays for the obstacle Collisions
Obstacle [] circleObstacles;
Obstacle [] rectObstacles;

int [] obstacleRectX;
int [] obstacleRectY;

int amountCircleObstacles = 8; //Amount of circle obstacles in the scene
int amountRectObstacles = 7; //Amount of rectangle obstacles in the scene

class Obstacle{
  boolean isCircle;
  
  float x;
  float y;
  float sizeX;
  float sizeY;
}

Obstacle InitCircleObstacle(){
  Obstacle tempCircle = new Obstacle();
  tempCircle.isCircle = true;
  tempCircle.x = random(width);
  tempCircle.y = random(height);
  tempCircle.sizeX = 60;
  tempCircle.sizeY = 20;
  
  return tempCircle;
}
Obstacle InitRectObstacle(){
  Obstacle tempRect = new Obstacle();
  tempRect.isCircle = false;
  tempRect.x = random(width);
  tempRect.y = random(height);
  tempRect.sizeX = 20;
  tempRect.sizeY = 20;
  
  return tempRect;
}
//SET UP
void InitializeObstaclesPosition(){
  //array inicialization for circular obstacles
  circleObstacles = new Obstacle[amountCircleObstacles];
  
  rectObstacles = new Obstacle[amountCircleObstacles];
  
  //Circular Obstacles are randomly located
  for(int counter = 0; counter < amountCircleObstacles; counter++){
    obstacleCircularX[counter] = (int)random(width);
    obstacleCircularY[counter] = (int)random(height);
  }
  
  //Rectangular Obstacles are randomly located
  for(int counter = 0; counter < amountRectObstacles; counter++){
    obstacleRectX[counter] = (int)random(width);
    obstacleRectY[counter] = (int)random(height);
  }

}

//DRAW
void drawObstacles(){
  // drawing the circular obstacles
  fill(0, 255, 0);
  for(int counter = 0; counter <amountCircleObstacles; counter++){
    ellipse(obstacleCircularX[counter], obstacleCircularY[counter], 20, 20);
    // Constrains a value to not exceed a maximum and minimum value, in this case the enemies can't exceed the window
    obstacleCircularX[counter] = constrain(obstacleCircularX[counter], 20, width - 20);
    obstacleCircularY[counter] = constrain(obstacleCircularY[counter], 20, height - 20);
    }
  
   // drawing the rectangular obstacles
  fill(0, 0, 255);
  for(int counter = 0; counter <amountRectObstacles; counter++){
    rect(obstacleRectX[counter], obstacleRectY[counter], 60, 20);
    // Constrains a value to not exceed a maximum and minimum value, in this case the enemies can't exceed the window
    obstacleRectX[counter] = constrain(obstacleRectX[counter], 20, width - 20);
    obstacleRectY[counter] = constrain(obstacleRectY[counter], 20, height - 20);
  }
}


//FUNCTIONS
//void mouseMoved(){
//  fill(255, 0, 0);
//  ellipse(mouseX, mouseY, radius_pc, radius_pc);
//// Evaluate collisions
//  for(int counter = 0; counter<amouont_npcs;counter++){
//    vector[0] = npc_x[counter] - mouseX; //Vx = NPCx - PCx
//    vector[1] = npc_y[counter] - mouseY; //Vy = NPCy - PCy
//    magnitude = sqrt(vector[0] * vector[0] + vector[1] * vector[1]); // = distance
//    // When are you having collisions?ç
//    if (magnitude < radius_npcs + radius_pc){
//    println("I just collided with ", counter);
//    } else println("I'm not colliding");
//  }
//}
