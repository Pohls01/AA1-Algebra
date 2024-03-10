
//VARIABLES
//Arrays for the obstacle Collisions
int [] obstacleCircularX;
int [] obstacleCircularY;

int [] obstacleRectX;
int [] obstacleRectY;

int amountCircleObstacles = 7; //Amount of circle obstacles in the scene
int amountRectObstacles = 7; //Amount of rectangle obstacles in the scene


//SET UP
void InitializeObstaclesPosition(){
  //array inicialization for circular obstacles
  obstacleCircularX = new int[amountCircleObstacles];
  obstacleCircularY = new int[amountCircleObstacles];
  
 //array inicialization for rectangular obstacles
  obstacleRectX = new int[amountRectObstacles];
  obstacleRectY = new int[amountRectObstacles];
  
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
  }
  
   // drawing the rectangular obstacles
  fill(0, 255, 0);
  for(int counter = 0; counter <amountRectObstacles; counter++){
    rect(obstacleRectX[counter], obstacleRectY[counter], 60, 20);
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
