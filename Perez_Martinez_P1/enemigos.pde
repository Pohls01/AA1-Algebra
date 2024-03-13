//Variables
int amountEnemies; // si pongo N no hace nada :')
float enemySpeed = 3;
float minEnemySpeed = 0.5;
float maxEnemySpeed = 2;
float minLoopDuration = 1500;
float maxLoopDuration = 3000;

ArrayList<PassiveEnemy> pEnemies = new ArrayList<PassiveEnemy>();
ArrayList<ChasingEnemy> cEnemies = new ArrayList<ChasingEnemy>();



class Enemy {
  boolean chasingEnemy;
  boolean deviating = false;
  float enemyColSize = 15;
  PVector position;
  Vector2 currDestination = new Vector2();
  Vector2 currDirection = new Vector2();
  float magnitude;
  float speedMultiplier;
  float speedLoopDuration;
  float loopStartTime;

  void GetNewDestination() {
  }

  void move() {
    PVector tempPos = new PVector (position.x, position.y);
    magnitude = dist(currDestination.x, currDestination.y, position.x, position.y);

    currDirection.x = (currDestination.x - position.x) / magnitude;
    currDirection.y = (currDestination.y - position.y) / magnitude;

    //PVector checkVector = new PVector (tempPos.x,tempPos.y);
    //checkVector.x += currDirection.x * enemySpeed * speedMultiplier;
    //checkVector.y += currDirection.y * enemySpeed * speedMultiplier;
    tempPos.x += currDirection.x * enemySpeed * speedMultiplier;
    tempPos.y += currDirection.y * enemySpeed * speedMultiplier;
    if (deviating) {
      //tempPos.x -= currDirection.x * enemySpeed * maxEnemySpeed;
      //tempPos.y -= currDirection.y * enemySpeed * maxEnemySpeed;
      if (dist(currDestination.x, currDestination.y, position.x, position.y) < 10) {
        deviating = false;
      }
    }
    if (millis() > loopStartTime + speedLoopDuration) {
      speedMultiplier = minEnemySpeed;
      loopStartTime = millis();
    }
    speedMultiplier =  minEnemySpeed + ((millis() - loopStartTime) / speedLoopDuration) * (maxEnemySpeed-minEnemySpeed);
    if (!calculateCollisions(tempPos, enemyColSize)) {
      position.x = constrain(tempPos.x, 10, width - 10);
      position.y = constrain(tempPos.y, 10, height - 10);
    } else {
      if (!chasingEnemy) {
        GetNewDestination();
      } else if (!deviating) {
        deviating = true;
        currDestination.x = position.x - currDirection.x * 120;
        currDestination.y = position.y - currDirection.y * 120;
      }
    }
  }
}

class PassiveEnemy extends Enemy {
  void GetNewDestination() {
    currDestination.x = random(15, width - 15);
    currDestination.y = random(15, height - 15);
  }
  void initializeEnemy() {
    position = new PVector(0, random(height));
    speedLoopDuration = random(minLoopDuration, maxLoopDuration);
    loopStartTime = millis();
    GetNewDestination();
  }
}

class ChasingEnemy extends Enemy {

  void UpdateDestination() {
    currDestination.x = npc2.position.x;
    currDestination.y = npc2.position.y;
  }
  void initializeEnemy() {
    chasingEnemy = true;
    position = new PVector(0, random(height));
    speedLoopDuration = random(minLoopDuration, maxLoopDuration);
    loopStartTime = millis();
    if (!deviating) {
      UpdateDestination();
    }
  }
}

void InitializeEnemies() {
  //Arrays Initialization

  //Enemies are randomly located


  // We label NPCs for the QuadTree quadrants
  // Top Left = 1
  // Top Right = 2
  // Bottom Right = 3
  // Bottom Left = 4


  //Inicializar un punto de destino para los enemigos
}


void drawEnemies() {
  fill(255, 0, 0);
  for (int i = 0; i < pEnemies.size(); i++) {
    PassiveEnemy enemy = pEnemies.get(i);
    ellipse(enemy.position.x, enemy.position.y, 20, 20);
  }
  for (int i = 0; i < cEnemies.size(); i++) {
    ChasingEnemy enemy = cEnemies.get(i);
    ellipse(enemy.position.x, enemy.position.y, 20, 20);
  }
}

//Mover a los enemigos a las coordenadas de destino
void moveEnemies() {
  //randomSeed(0);
  for (int i = 0; i < pEnemies.size(); i++) {
    PassiveEnemy enemy = pEnemies.get(i);
    enemy.move();
    if (enemy.magnitude < 30) {
      enemy.GetNewDestination();
    }
  }
  for (int i = 0; i < cEnemies.size(); i++) {
    ChasingEnemy enemy = cEnemies.get(i);
    if (!enemy.deviating) {
      enemy.UpdateDestination();
    }
    enemy.move();
  }


  //    // Movimiento de dirección a Coordenadas
  //    float direccioX = desiredX - enemy.x;
  //    float direccioY = desiredY - enemy.y;
  //    float magnitud = dist(desiredX, desiredY, enemyX[i], enemyY[i]);

  //    // Normaliza el vector de dirección
  //    direccioX /= magnitud;
  //    direccioY /= magnitud;

  //    // Aplica el movimiento en la dirección normalizada
  //    enemyX[i] += direccioX * enemySpeed;
  //    enemyY[i] += direccioY * enemySpeed;

  // Constrains a value to not exceed a maximum and minimum value, in this case the enemies can't exceed the window
  //enemyX[i] = constrain(enemyX[i], 10, width - 10);
  //enemyY[i] = constrain(enemyY[i], 10, height - 10);
}
// Cambia las coordenadas de destino cada cierto tiempo
