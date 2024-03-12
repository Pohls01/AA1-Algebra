//Variables
boolean inStart = true;
PFont titulo;
int N = 0;
int vidas = 3;
int salud = 100;
int currentTime;
int timeLeft;
int maxTimeGame = 150;
int score = 0;

Player player;

PImage PJimage;
PImage PNJ1image;
PImage PNJ2image;
PImage fondito;

//Set Up - Se ejecuta 1 vez al principio
void setup(){
  //La ventana
  //size(1800, 1200);
  fullScreen();
  
  setupInputs();
  titulo = createFont("Cyberpunks Italic.ttf", 50);
  //color de fondo
  InitializeObstaclesPosition();
  InitializeEnemies();
  //NewDestination();
  
  
  //Initialize/Load images 
  PJimage = loadImage("idle.png");
  fondito = loadImage("background.jpg"); //no se porque si se pone el fondo en background espolota xd
  
}

//Escena inicial
void startDraw(){
  background(255);
  image(fondito, 0, 0);
  fondito.resize(width, height);
  textFont(titulo);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Introduce the number of enemies", width/2, height/2-50);
  textSize(75);
  text(N, width/2, height/2+30);
  startButton.drawButton();
  text("Presiona M(Ratón) o K(Teclado) para cambiar el movimiento", 800, 800);
}

void gameSetup(){
  player = InitializePlayer();
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
  timeLeft = maxTimeGame;
  currentTime = millis();
  
}
//Draw - Se ejecuta infinitas veces en bucle
void draw(){
  if(inStart){
    startDraw();
  }
  else{
    
  background(0);
  //Pintar el PJ
 
  
  image(PJimage, mouseX, mouseY);
  PJimage.resize(40, 48);
  
  
  //fill(#AA514E);
  //ellipse(player.x, player.y, 30.0, 30.0);
  
  
  
  drawNPCs();
  drawEnemies();
  player.move();
  moveEnemies();
  drawObstacles();
  
  
  //Contador de tiempo restante de partida
  if(millis()-currentTime >= 1000){
    timeLeft--;
    currentTime = millis();
  }
  text(timeLeft/60+":"+timeLeft%60,1000,50);
  }
}
//Otras funciones
