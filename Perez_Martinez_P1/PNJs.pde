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
  //boolean takesDamage;
  PVector position;
  float alpha = 0.075;
  float npcColSize = 15;
  float offset;
  float speed;
  PVector targetPoint = new PVector(0,0);
  
  void getTargetPoint(PVector target){
    
    float angle = atan(abs(target.y-position.y)/abs(target.x-position.x));
    targetPoint.x = target.x - signum(target.x-position.x)* offset * cos(angle);
    targetPoint.y = target.y - signum(target.y-position.y)* offset * sin(angle);
  }
  
  void move(PVector target){
    getTargetPoint(target);
    PVector tempPos = new PVector(position.x, position.y);
    PVector direction = new PVector(targetPoint.x-position.x,targetPoint.y-position.y);
    if(sqrt(pow(direction.x,2) + pow(direction.y,2)) > followThreshold /*&& sqrt(pow(direction.x,2) + pow(direction.y,2)) > offset*/){
    direction.normalize();
    tempPos.x += direction.x * speed;
    tempPos.y += direction.y * speed;
    if(!calculateCollisions(tempPos, npcColSize)){  
      position.x = constrain (tempPos.x, 5, width-5);
      position.y = constrain (tempPos.y, 5, height-5);
    }
    }
  }
}
NPC InitializeNPC1(){
  NPC tempNPC = new NPC();
  //tempNPC.takesDamage = false;
  do{
  tempNPC.position = new PVector(random(width), random(height));
  } while(calculateCollisions(tempNPC.position, tempNPC.npcColSize));
  tempNPC.offset = 80;
  tempNPC.speed = 10;
  tempNPC.getTargetPoint(player.position);
  return tempNPC;
}
NPC InitializeNPC2(){
  NPC tempNPC = new NPC();
  //tempNPC.takesDamage = false;
  do{
  tempNPC.position = new PVector(random(width), random(height));
  } while(calculateCollisions(tempNPC.position, tempNPC.npcColSize));
  tempNPC.offset = 150;
  tempNPC.speed = 9;
  tempNPC.getTargetPoint(npc1.position);
  return tempNPC;
}

//float xNPC = width / 2;
//float yNPC = height / 2;
//float xNPC2 = width / 2;
//float yNPC2 = height / 2;
//float alpha = 0.075;
//float angleNPC1;
//float angleNPC2;

//Pintar los NPCs
void drawNPCs(){
  npc1.move(player.position);
  npc2.move(npc1.position);
  //Se dibuja el NPC1
  fill(#C78DA3);
  image(PNJsimage, npc1.position.x, npc1.position.y);
  
  
  //Se dibuja el NPC2
  fill(#FBD2C1);
  image(PNJsimage, npc2.position.x, npc2.position.y);
}

//La función signum devuelve +1 o -1 en función del signo del número pasado como parámetro. Devuelve 0 si el número es 0
int signum(float number){
  if (number > 0) return 1;
  if (number < 0) return -1;
  return 0;
}
