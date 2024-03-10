//Variables
float enemyX, enemyY;
float enemySpeed;

//Draw

void DrawEnemy(){
  enemyX = 0;
  enemyY = random(height);
  
  fill(255, 0, 0);
  ellipse(enemyX, enemyY, 20, 20);
  

}
void MoveEnemy(){


}



void SpawnEnemies(){
  for(int counter = 0; counter < N; counter++){
    DrawEnemy();
  }


}
