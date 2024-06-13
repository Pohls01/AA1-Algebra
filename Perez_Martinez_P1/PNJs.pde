//Un PNJ persigue a un PJ
//Usamos la eq paramétrica de la recta
//r(alpha) = P + aplha * vector
//vector = Q - P
//Q sera la posición del PJ (final)
//P sera la posición del PNJ (inicial)
//El PJ, osea Q, esta en la posición del ratón

NPC npc1;
NPC npc2;

class NPC{
    boolean takesDamage;
    boolean deviating;
    boolean following = false;
    PVector position;
    float alpha = 0.075;
    float npcColSize = 15;
    float offset;
    float speed;
    int unstuckTime;
    PVector targetPoint = new PVector(0,0);
    
    //Función para calcular la posición a la que se dirige el NPC
    void getTargetPoint(PVector target) {
        
        float angle = atan(abs(target.y - position.y) / abs(target.x - position.x));
        targetPoint.x = target.x - signum(target.x - position.x) * offset * cos(angle);
        targetPoint.y = target.y - signum(target.y - position.y) * offset * sin(angle);
    }
    

    void move(PVector target) {
        if (enemyCollide(position,npcColSize)) {
            checkDamage(20);
        }
        if (!deviating) {
            getTargetPoint(target);
        }
        PVector tempPos = new PVector(position.x, position.y);
        PVector direction = new PVector(targetPoint.x - position.x,targetPoint.y - position.y);
        if (deviating && (dist(position.x, position.y, targetPoint.x, targetPoint.y) < 10 || millis() - 500 > unstuckTime)) {
            deviating = false;
        }
        if (sqrt(pow(direction.x,2) + pow(direction.y,2)) > followThreshold || deviating/*&& sqrt(pow(direction.x,2) + pow(direction.y,2)) > offset*/){
            direction.normalize();
            tempPos.x += direction.x * speed;
            tempPos.y += direction.y * speed;

            if(!calculateCollisions(tempPos, npcColSize)){  
                position.x = constrain (tempPos.x, 5, width-5);
                position.y = constrain (tempPos.y, 5, height-5);
            }
            else{
                if(!deviating){
                    deviating = true;
                    targetPoint.x = position.x-direction.x*100;
                    targetPoint.y = position.y-direction.y*100;
                    unstuckTime = millis();
                }
                if(takesDamage){
                    checkDamage(10);
                } 
            }
        }
    }
}

//Inicialización de los NPCs
NPC InitializeNPC1(){
        NPC tempNPC = new NPC();
        tempNPC.takesDamage = false;
    do{
        tempNPC.position = new PVector(random(windowMargin, width - windowMargin), random(windowMargin, height - windowMargin));
    } while(calculateCollisions(tempNPC.position, tempNPC.npcColSize));
        tempNPC.offset = 80;
        tempNPC.speed = 9;
        tempNPC.getTargetPoint(player.position);
        return tempNPC;
}

NPC InitializeNPC2(){
    NPC tempNPC = new NPC();
    tempNPC.takesDamage = true;
    do{
        tempNPC.position = new PVector(random(windowMargin, width - windowMargin), random(windowMargin, height - windowMargin));
    } while(calculateCollisions(tempNPC.position, tempNPC.npcColSize));
        tempNPC.offset = 150;
        tempNPC.speed = 8;
        tempNPC.getTargetPoint(npc1.position);
        return tempNPC;
}

//Función para comprobar si el enemigo colisiona con el jugador        
void checkDamage(int damage){
    if (millis() - gracePeriod > lastDamage){
        salud -= damage;
    if(salud <= 0){
        vidas--;
        salud = 100;
    }
    lastDamage = millis();
    }
}
        

//Pintarlos NPCs
void drawNPCs(){
        if (collideEntities(player.position, player.playerSize, npc1.position, npc1.npcColSize)){
            npc1.following = true;
        }
        if (collideEntities(player.position, player.playerSize, npc2.position, npc2.npcColSize) && npc1.following){
            npc2.following = true;
            allNPCsCollected = true;
        }
        if (npc1.following){
            npc1.move(player.position);
        }
        if (npc2.following){
            npc2.move(npc1.position);
        }
        //Sedibuja el NPC1
        fill(#C78DA3);
        image(PNJimage, npc1.position.x, npc1.position.y);

        //Sedibuja el NPC2
        fill(#FBD2C1);
        image(PNJ2image, npc2.position.x, npc2.position.y);
}
        
//La función signum devuelve +1 o -1 en función del signo del número pasado como parámetro. Devuelve 0 si el número es 0
int signum(float number){
    if (number > 0) return 1;
    if (number < 0) return -1;
    return 0;
} 
 

        
        
