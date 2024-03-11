//Variables
boolean inStart = true;
PFont titulo;
int N = 0;
int vidas = 3;
int timeGame = 1000;
int score = 0;



//Set Up - Se ejecuta 1 vez al principio
void setup(){
  //La ventana
  size(1200,800);
  
  setupInputs();
  titulo = createFont("Cyberpunks Italic.ttf", 50);
  //color de fondo
  
  InitializeObstaclesPosition();
  InitializeEnemies();
  //NewDestination();
  
}

//Escena inicial
void startDraw(){
  background(255);
  textFont(titulo);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Introduce the number of enemies", width/2, height/2-50);
  textSize(75);
  text(N, width/2, height/2+30);
  startButton.drawButton();
}

void gameSetup(){
  int i = 0;
  for (; i < N/2; i++){
    PassiveEnemy pEnemy = new PassiveEnemy();
    pEnemy.initializeEnemy();
    pEnemies.add(pEnemy);
  }
  for (; i < N; i++){
    ChasingEnemy cEnemy = new ChasingEnemy();
    cEnemy.initializeEnemy();
    cEnemies.add(cEnemy);
  }
}
//Draw - Se ejecuta infinitas veces en bucle
void draw(){
  if(inStart){
    startDraw();
  }
  else{
    
  background(0);
  //Pintar el PJ
  fill(#AA514E);
  ellipse(mouseX, mouseY, 30.0, 30.0);
  
  drawNPCs();
  drawEnemies();
  moveEnemies();
  drawObstacles();

  }
  
}
//Otras funciones
