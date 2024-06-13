//Variables

//Scene Managing Variables
boolean inStart = true;
boolean inBoss = false;

int N = 0;
int vidas = 3;
int salud = 100;

//Time variables
int currentTime;
int timeLeft;
int maxTimeGame = 150;

int score = 0;
int gracePeriod = 1000;
int lastDamage = 0;

boolean allNPCsCollected = false;

float followThreshold = 15;

Player player;
Bullet myBullet;

PImage PJimage;
PImage PNJimage, PNJ2image;
PImage enemies, boss;
PImage circularobstacle, rectobstacle;
PImage title;
PImage fondito, gateopen, gateclosed, gatespikes;
PImage death, win;
PImage bomb;

PFont titulo;

//Añadimos un margen para que los obstáculos no se superpongan con los bordes y evitar que enemigos se queden atascados
int windowMargin = 100; //Margin of the window

//Set Up - Se ejecuta 1 vez al principio
void setup() {
    //DISCLAIMER!!! Cambiar a size en caso de problemas con la resolución en fullScreen
    size(1920, 1080);
    // fullScreen();
    
    setupInputs();

    //Initialize/Load fonts
    titulo = createFont("Cyberpunks Italic.ttf", 50);
    
    //Initialize/Load images 
    fondito = loadImage("background.png"); 
    title = loadImage("titulo.png");
    gateopen = loadImage("gateopen.png");
    gateclosed = loadImage("gateclosed.png");
    gatespikes = loadImage("gatespikes.png");
    PJimage = loadImage("PJ.png");
    PNJimage = loadImage("PNJ.png");
    PNJ2image = loadImage("PNJ2.png");
    enemies = loadImage("enemy.png");
    circularobstacle = loadImage("circleobstacle.png");
    rectobstacle = loadImage("rectangleobstacle.png");
    death = loadImage("death.png");
    win = loadImage("win.png");
    bomb = loadImage("bomb.png");
    boss = loadImage("boss.png");
}

//Escena Title Screen
void startDraw() {
    //background(255);
    imageMode(CORNER);
    image(fondito, 0, 0);
    fondito.resize(width, height);
    imageMode(CENTER);
    image(title, width/2 , 300);
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
    text("Press M (Mouse) o K (Keyboard) INGAME to change Movement System", width / 2, height / 2 + 250);
    
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

    // activePowerUp = InitializePowerUp(); 
    // if(allNPCsCollected){
       
    // }
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
    background(gatespikes);
    //imageMode(CENTER);
    player.move();
    image(PJimage, player.position.x, player.position.y);
    myBoss.move();
    myBoss.drawBoss();
    bossShoot();
    bulletMove();
    
    textSize(70);
    fill(255);
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
            background(fondito);
            textSize(25);
            textAlign(CENTER);
            fill(255);
            image(death, width / 2, height / 2);
            text("YOU DIED", width / 2, height / 2 + 200);
            text("Score: " + player.score, width / 2, height / 2 + 250);
            
            
            
            
        }
        else{
            //Third Scene
            if (inBoss) {
                if (bossKilled) {
                    background(fondito);
                    textSize(25);
                    textAlign(CENTER);
                    fill(255);
                    image(win, width / 2, height / 2);
                    text("YOU WON", width / 2, height / 2 + 200);
                    text("Score: " + player.score, width / 2, height / 2 + 250);
                    
                   
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
                
                //Los power ups se muestran solo si se han recogido todos los NPCs
                if(activePowerUp != null){
                    activePowerUp.drawPowerUp();
                }

                player.move();

                drawNPCs();
                
                //Genera las oleadas de enemigos cada 30 segundos
                if (millis() - lastWaveTime >= 20000) {
                    lastWaveTime = millis();
                    generateWave(N);
                }

                drawEnemies();
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
                
                if(allNPCsCollected){
                text(activePowerUp.description, width / 2, height - 100);
                }
                text("PowerUps: " + powerUpCount, 100, height - 100);
                
                text(salud + " HP - Vidas: " + vidas, 100,100);
                text("Score: " + player.score, width - 500, 100);
                textAlign(CENTER);
                
            }
            
            
            //Contadorde tiempo restante de partida
            if (millis() - currentTime >= 1000) {
                timeLeft--;
                currentTime = millis();
            }
            
        }
    }
}
