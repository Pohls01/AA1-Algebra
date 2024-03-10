

//Variables
boolean inStart = true;
//boolean inEnemyArena;
PFont titulo;
int N = 0;
int vidas = 3;
int timeGame = 1000;



//Set Up - Se ejecuta 1 vez al principio
void setup(){
  //La ventana
  size(1200,1200);
  
  setupInputs();
  titulo = createFont("Cyberpunks Italic.ttf", 50);
  //color de fondo
  InitializeObstaclesPosition();
  InitializeEnemies();
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
  //inEnemyArena = true;
  drawEnemies();
  moveEnemies();
  drawObstacles();

  }
  
}
//Otras funciones
