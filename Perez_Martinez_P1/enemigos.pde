//Variables
float[] enemyX, enemyY;
int [] enemyQuadrant;
int amountEnemies = 12; // si pongo N no hace nada :')
float enemySpeed = 2;

void InitializeEnemies() {
  //Arrays Initialization
  enemyX = new float[amountEnemies];
  enemyY = new float[amountEnemies];
  enemyQuadrant = new int[amountEnemies];
  
  //Enemies are randomly located
  for (int i = 0; i < amountEnemies; i++) {
   enemyX[i] = 0; //los enemigos  aparecen paulatinamente del lado izquierdo de la ventana
   enemyY[i] = (int)random(height);
   
   
   // We label NPCs for the QuadTree quadrants
  // Top Left = 1
  // Top Right = 2
  // Bottom Right = 3
  // Bottom Left = 4
  for (int counter=0; counter<amountEnemies; counter++) {
    if (enemyX[counter]<width/2.0) {
      if (enemyY[counter]<height/2.0) enemyQuadrant[counter] = 1;
      else enemyQuadrant[counter] = 4;
    } else {
      if (enemyY[counter]<height/2.0) enemyQuadrant[counter] = 2;
      else enemyQuadrant[counter] = 3;
    }
  }
  }
  
  //Inicializar un punto de destino para los enemigos
  NewDestination();
  
}

void drawEnemies() {
  for (int i = 0; i < amountEnemies; i++) {
    fill(255, 0, 0);
    ellipse(enemyX[i], enemyY[i], 20, 20);
  }
}


//Coordenadas de destino
float desiredX = random(height); 
float desiredY = random(width);

//Función para nuevas coordenadas
void NewDestination(){
  desiredX = random(height); 
  desiredY = random(width);

}

//Mover a los enemigos a las coordenadas de destino
void moveEnemies() {
  randomSeed(0);
  for (int i = 0; i < amountEnemies; i++) {
    NewDestination();
    // Movimiento de dirección a Coordenadas
    float direccioX = desiredX - enemyX[i];
    float direccioY = desiredY - enemyY[i];
    float magnitud = dist(desiredX, desiredY, enemyX[i], enemyY[i]);
    
    // Normaliza el vector de dirección
    direccioX /= magnitud;
    direccioY /= magnitud;

    // Aplica el movimiento en la dirección normalizada
    enemyX[i] += direccioX * enemySpeed;
    enemyY[i] += direccioY * enemySpeed;
    
    // Constrains a value to not exceed a maximum and minimum value, in this case the enemies can't exceed the window
    enemyX[i] = constrain(enemyX[i], 0, width);
    enemyY[i] = constrain(enemyY[i], 0, height);
    }
  }
