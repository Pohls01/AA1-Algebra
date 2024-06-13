Boss myBoss;
int bulletsPerShot = 10;
float bossSpeed = 3;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
boolean bossKilled = false;
int bulletWait = 1500;
int lastBullet = 0;
int bulletRadius = 40;

class Boss {
    int health = 100;
    PVector position;
    PVector currDestination = new PVector(0,0);
    PVector currDirection = new PVector(0,0);
    float magnitude;
    
    void move() {
        currDestination.x = player.position.x; 
        currDestination.y = player.position.y;
        
        magnitude = dist(currDestination.x, currDestination.y, position.x, position.y);
        currDirection.x = (currDestination.x - position.x) / magnitude;
        currDirection.y = (currDestination.y - position.y) / magnitude;
        
        position.x -= currDirection.x * bossSpeed;
        position.y -= currDirection.y * bossSpeed;
    }
    
    void drawBoss() {
        stroke(0);
        fill(0, 0, 0);
        image(boss, position.x, position.y);
        if (position.x < 110 || position.x > width - 110 || position.y < 110 || position.y > height - 110) {
            health -= 20;
            position.x = width / 2;
            position.y = height / 2;
            if (health <= 0)
                bossKilled = true;
                
        }
    }
}

Boss initializeBoss() {
    Boss tBoss = new Boss();
    tBoss.position = new PVector(width / 2, height / 2);
    //speedLoopDuration = random(minLoopDuration, maxLoopDuration);
    //loopStartTime = millis();
    return tBoss;
}

class Bullet{
    PVector bulletPos;
    PVector bulletDirection;
    PVector bulletSize;
    boolean active = true;
    color bulletColor;
    float bulletAngle;
    int bulletSpeed = 10;
    
    //Posible manera de cargarse al Boss
    void drawBullet() {
        if(active){
        fill(bulletColor);
        image(bomb, bulletPos.x, bulletPos.y);
        }
    }
    void move() {
        bulletPos.x += bulletDirection.x * bulletSpeed;
        bulletPos.y += bulletDirection.y * bulletSpeed;
        if(active && collideEntities(bulletPos, bulletSize.x, player.position, player.playerSize)) {
            checkDamage(25);
            active = false;
        }
    }
    
}

void bossShoot() {
    if (millis() - bulletWait > lastBullet) {
        emptyArrayList(bullets);
        float tempAngle = 0;
        float increase = 360 / bulletsPerShot;
        for (int i = 0; i < bulletsPerShot; i++) {
            
            myBullet = new Bullet();
            myBullet.bulletPos = new PVector(myBoss.position.x , myBoss.position.y);
            myBullet.bulletSpeed = 10;
            myBullet.bulletAngle = tempAngle;
            myBullet.bulletDirection = new PVector(cos(tempAngle), sin(tempAngle));
            myBullet.bulletSize = new PVector(bulletRadius, bulletRadius);
            myBullet.bulletColor = color(0, 255, 0);
            tempAngle += radians(increase);
            bullets.add(myBullet);
        }
        lastBullet = millis();

    }
}
void bulletMove() {
    for (int i = 0; i < bullets.size(); i++) {
        Bullet b = bullets.get(i);
        b.move();
        b.drawBullet();
    }
}
