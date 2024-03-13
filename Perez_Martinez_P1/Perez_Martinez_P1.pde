//Variables
boolean inStart = true;
boolean inBoss = false;
PFont titulo;
int N = 0;
int vidas = 3;
int salud = 100;
int currentTime;
int timeLeft;
int maxTimeGame = 150;
int score = 0;

float followThreshold = 15;

Player player;

PImage PJimage;
PImage PNJsimage;
PImage fondito;

//Set Up - Se ejecuta 1 vez al principio
void setup(){
  //La ventana
  //size(1920, 1080);
  fullScreen();
  
  setupInputs();
  titulo = createFont("Cyberpunks Italic.ttf", 50);
  //color de fondo
  //NewDestination();
  
  
  
  //Initialize/Load images 
  PJimage = loadImage("PJ.png");
  PNJsimage = loadImage("PNJ.png");
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
  
  textSize(25);
  textAlign(CENTER);
  fill(0);
  text("Presiona M (Ratón) o K (Teclado) INGAME para cambiar el movimiento", width/2, height/2 + 250);
 
}

//In Function when startDraw button is pressed
void gameSetup(){
  InitializeObstaclesPosition();
  player = InitializePlayer();
  npc1 = InitializeNPC1();
  npc2 = InitializeNPC2();
  InitializeEnemies();
  
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
  
  
   activePowerUp = InitializePowerUp();
   myBoss = initializeBoss();
   
}
//Boss Set Up Scene

void BossSetUp(){
circleObstacles = new Obstacle[0];
rectObstacles = new Obstacle[0];

}
//Boss Scene
void bossScene(){
  background(255);
//imageMode(CENTER);
  image(PJimage, player.position.x, player.position.y);
  player.move();
  myBoss.move();
  myBoss.drawBoss();
  
  
  

}

//Draw - Se ejecuta infinitas veces en bucle
void draw(){
  //First Scene of the game
  if(inStart){
    startDraw();
  }
  //Third Scene
  else if(inBoss){
  bossScene();
  
  
  }
  //Middle Scene
  else{
    
  background(255);
  
  //Pintar el PJ
  imageMode(CENTER);
  image(PJimage, player.position.x, player.position.y);
  
  
  
  //fill(#AA514E);
  //ellipse(player.x, player.y, 30.0, 30.0);
  
  drawEnemies();
  player.move();
  
  drawNPCs();
 
  moveEnemies();
  
  
  drawObstacles();
  
  activePowerUp.drawPowerUp();
  
  
  //Contador de tiempo restante de partida
  if(millis()-currentTime >= 1000){
    timeLeft--;
    currentTime = millis();
  }
  textSize(70);
  text(timeLeft/60+":"+nf(timeLeft%60,2),width/2,100);
  }
}
//Otras funciones
