Boss myBoss;

float bossSpeed = 2;

class Boss {
  PVector position;
  Vector2 currDestination = new Vector2();
  Vector2 currDirection = new Vector2();
  float magnitude;
  //float speedMultiplier;
  //float speedLoopDuration;
  //float loopStartTime;


  void move() {

    currDestination.x = player.position.x; 
    currDestination.y = player.position.y;

    
    magnitude = dist(currDestination.x, currDestination.y, position.x, position.y);
    currDirection.x = (currDestination.x - position.x) / magnitude;
    currDirection.y = (currDestination.y - position.y) / magnitude;

    position.x += currDirection.x * bossSpeed;
    position.y += currDirection.y * bossSpeed;

  //  if (millis() > loopStartTime + speedLoopDuration) {
  //    speedMultiplier = minEnemySpeed;
  //    loopStartTime = millis();
  //  }

  //  speedMultiplier =  minEnemySpeed + ((millis() - loopStartTime) / speedLoopDuration) * (maxEnemySpeed-minEnemySpeed);
  //  position.x = constrain(position.x, 10, width - 10);
  //  position.y = constrain(position.y, 10, height - 10);
  //}
 
    
  }
  
  
  void drawBoss() {
    fill(0, 0, 0);
    ellipse(myBoss.position.x, myBoss.position.y, 100, 100);
}

}

Boss initializeBoss() {
    Boss myBoss = new Boss();
    myBoss.position = new PVector(width/2, height/2);
    //speedLoopDuration = random(minLoopDuration, maxLoopDuration);
    //loopStartTime = millis();
    return myBoss;
  }


  
