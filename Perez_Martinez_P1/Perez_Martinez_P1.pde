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
int gracePeriod = 1000;
int lastDamage = 0;

float followThreshold = 15;

Player player;
Bullet myBullet;

PImage PJimage;
PImage PNJsimage;
PImage enemies;
PImage circularobstacle, rectobstacle;
PImage fondito, gateopen, gateclosed;



//Set Up - Se ejecuta 1 vez al principio
void setup() {
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
    enemies = loadImage("enemy.png");
    circularobstacle = loadImage("circleobstacle.png");
    rectobstacle = loadImage("rectangleobstacle.png");
    fondito = loadImage("background.png"); //no se porque si se pone el fondo en background espolota xd
    gateopen = loadImage("gateopen.png");
    gateclosed = loadImage("gateclosed.png");
}

//Escena inicial
void startDraw() {
    //background(255);
    image(fondito, 0, 0);
    fondito.resize(width, height);
    textFont(titulo);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Introduce the number of enemies", width / 2, height / 2 - 50);
    textSize(75);
    
    text(N, width / 2, height / 2 + 30);
    startButton.drawButton();
    
    textSize(25);
    textAlign(CENTER);
    fill(255);
    text("Presiona M (Ratón) o K (Teclado) INGAME para cambiar el movimiento", width / 2, height / 2 + 250);
    
}

//In Function when startDraw button is pressed
void gameSetup() {
    InitializeObstaclesPosition();
    player = InitializePlayer();
    npc1 = InitializeNPC1();
    npc2 = InitializeNPC2();
    InitializeEnemies();
    
    int i = 0;
    for (; i < N / 2; i++) {
        PassiveEnemy pEnemy = new PassiveEnemy();
        pEnemy.initializeEnemy();
        pEnemies.add(pEnemy);
    }
    for (; i < N; i++) {
        ChasingEnemy cEnemy = new ChasingEnemy();
        cEnemy.initializeEnemy();
        cEnemies.add(cEnemy);
    }
    timeLeft = maxTimeGame;
    currentTime = millis();
    
    
    activePowerUp = InitializePowerUp();
    //myBullet = Bullet.initializeBullets();

    
    
}
//Boss Set Up Scene

void BossSetUp() {
    circleObstacles = new Obstacle[0];
    rectObstacles = new Obstacle[0];
    emptyArrayList(pEnemies);
    emptyArrayList(cEnemies);
    myBoss = initializeBoss();
    
    
}
//Boss Scene
void bossScene() {
    background(gateopen);
    //imageMode(CENTER);
    player.move();
    image(PJimage, player.position.x, player.position.y);
    myBoss.move();
    myBoss.drawBoss();
    // bossShoot();
    
    textSize(70);
    fill(0);
    text(timeLeft / 60 + ":" + nf(timeLeft % 60,2),width / 2,100);
    textAlign(LEFT);
    text(salud + " HP - Vidas: " + vidas, 100,100);
    textAlign(RIGHT);
    text("Jefe: " + myBoss.health, width - 100, 100);
    textAlign(CENTER);
    
}

//Draw - Se ejecuta infinitas veces en bucle
void draw() {
    // First Scene of thegame
    if (inStart) {
        startDraw();
    }
    else{
        if (timeLeft <= 0 || vidas == 0) {
            background(153);
            textSize(25);
            textAlign(CENTER);
            fill(0);
            text("HAS MUERTO", width / 2, height / 2 + 250);
            
            
        }
        else{
            //Third Scene
            if (inBoss) {
                if (bossKilled) {
                    background(153);
                    textSize(25);
                    textAlign(CENTER);
                    fill(0);
                    text("HAS GANADO", width / 2, height / 2 + 250);
                }
                else{
                    bossScene();
                }
            }
            //Middle Scene
            else{
                if(powerUpCount >= 5){
                     background(gateopen);

                    PVector obstaclePosition = new PVector(510, 0);
                    PVector obstacleSize = new PVector(100, 200);

                    //Deteccion de la colision del Portal
                    fill(255, 0, 0);
                    rect(obstaclePosition.x, obstaclePosition.y, obstacleSize.x, obstacleSize.y);
                    if (collideEntities(player.position, player.playerSize, obstaclePosition, 200)){
                        //Booleano para cambiar de escena a BOSS
                        inBoss = true;
                        bulletActive = true;
                        BossSetUp();
                    }

                    
                }
                else{
                background(gateclosed);
                }
                
                activePowerUp.drawPowerUp();
                
                drawEnemies();
                player.move();
                
                //updateNPCs();
                drawNPCs();
                
                moveEnemies();
                
                
                drawObstacles();
                
                //Pintar el PJ
                imageMode(CENTER);
                image(PJimage, player.position.x, player.position.y);
                
                
                //Contadorde tiempo restantede partida
                if (millis() - currentTime >= 1000) {
                    timeLeft--;
                    currentTime = millis();
                }
                textSize(70);
                fill(0);
                text(timeLeft / 60 + ":" + nf(timeLeft % 60,2),width / 2,100);
                textAlign(LEFT);
                text(activePowerUp.description, width / 2, height - 100);
                text("PowerUps: " + powerUpCount, 100, height - 100);
                text(salud + " HP - Vidas: " + vidas, 100,100);
                textAlign(CENTER);
                
            }
            
            
            //fill(#AA514E);
            //ellipse(player.x, player.y, 30.0, 30.0);
            
            //Contadorde tiempo restante de partida
            if (millis() - currentTime >= 1000) {
                timeLeft--;
                currentTime = millis();
            }
            
        }
    }
}
