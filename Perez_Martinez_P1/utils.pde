class Vector2{
  float x;
  float y;
}

char charUpper(char c){
  if(c >= 'a' && c <= 'z'){
    c += 'a' - 'A';
  }
  return c;
}

int getQuadrant(PVector position) {
  if (position.x<width/2.0) {
    if (position.y<height/2.0) return 1;
    else return 4;
  } else {
    if (position.y<height/2.0) return 2;
    else return 3;
  }
}
boolean calculateCollisions(PVector pos, float colSize){
  // Evaluate collisions
  PVector min_pc = new PVector(pos.x-colSize, pos.y-colSize);
  PVector max_pc = new PVector(pos.x+colSize, pos.y+colSize);
  int quadrant = getQuadrant(pos);
  for(int i = 0; i<circleObstacles.length;i++){
    if(circleObstacles[i].obsQuadrant == quadrant){
      if(sqrt(pow(circleObstacles[i].position.x-pos.x,2) + pow(circleObstacles[i].position.y-pos.y,2)) <= circleObstacles[i].size.x + colSize){
        return true;
      }
    }
  }
  for(int i = 0; i<rectObstacles.length;i++){
    if(rectObstacles[i].obsQuadrant == quadrant){
      if(!((max_pc.x<rectObstacles[i].min_obs.x)||(max_pc.y<rectObstacles[i].min_obs.y) || (rectObstacles[i].max_obs.x<min_pc.x)||(rectObstacles[i].max_obs.y<min_pc.y))){
        return true;
      }
    }
  }
  return false;
}

int GetRandomSign(){
  float tempInt = random(-1,1);
  if(tempInt<0) return -1;
  else return 1;
}

boolean enemyCollide(PVector pos, float colSize){
  int quadrant = getQuadrant(pos);
  for(int i = 0; i<pEnemies.size();i++){
    PassiveEnemy enemy = pEnemies.get(i);
    if(quadrant == getQuadrant(enemy.position)){
      if(sqrt(pow(enemy.position.x-pos.x,2) + pow(enemy.position.y-pos.y,2)) <= enemy.enemyColSize + colSize){
        return true;
      }
    }
  }
    for(int i = 0; i<cEnemies.size();i++){
    ChasingEnemy enemy = cEnemies.get(i);
    if(quadrant == getQuadrant(enemy.position)){
      if(sqrt(pow(enemy.position.x-pos.x,2) + pow(enemy.position.y-pos.y,2)) <= enemy.enemyColSize + colSize){
        return true;
      }
    }
  }
  return false;
}
