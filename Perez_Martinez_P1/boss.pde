Boss myBoss;

float bossSpeed = 3;


class Boss {
  PVector position;
  Vector2 currDestination = new Vector2();
  Vector2 currDirection = new Vector2();
  float magnitude;
  


  void move() {

    currDestination.x = player.position.x; 
    currDestination.y = player.position.y;

    
    magnitude = dist(currDestination.x, currDestination.y, position.x, position.y);
    currDirection.x = (currDestination.x - position.x) / magnitude;
    currDirection.y = (currDestination.y - position.y) / magnitude;

    position.x += currDirection.x * bossSpeed;
    position.y += currDirection.y * bossSpeed;
    
  }
  
  
  void drawBoss() {
    stroke(0);
    fill(0, 0, 0);
    ellipse(myBoss.position.x, myBoss.position.y, 200, 200);
}

}

Boss initializeBoss() {
    Boss myBoss = new Boss();
    myBoss.position = new PVector(width/2, height/2);
    //speedLoopDuration = random(minLoopDuration, maxLoopDuration);
    //loopStartTime = millis();
    return myBoss;
  }


  
