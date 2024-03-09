//a tiny collision detector

//PC = a red circle (via mouse)
//NPC's = green circles (static)

//VARIABLES
//Arrays for the NPC
int [] npc_x;
int [] npc_y;
int amount_npcs = 10; //10 npcs in the scene
int radius_npcs = 20;
int radius_pc = 5;

//SET UP
void setupCollisions(){
  //array inicialization
  npc_x = new int[amount_npcs];
  npc_y = new int[amount_npcs];
  //NPCs are randomly located
  for(int counter = 0; counter <amount_npcs; counter++){
    npc_x[counter] = (int)random(width);
    npc_y[counter] = (int)random(height);
   
  }

}

//DRAW
//void draw(){
//  //Background
//  background(0);
//  // drawing the npcs
//  fill(0, 255, 0);
//  for(int counter = 0; counter <amount_npcs; counter++){
//    ellipse(npc_x[counter], npc_y[counter], radius_npcs, radius_npcs);
//  }
//}


//FUNCTIONS
//void mouseMoved(){
//  fill(255, 0, 0);
//  ellipse(mouseX, mouseY, radius_pc, radius_pc);
//// Evaluate collisions
//  for(int counter = 0; counter<amouont_npcs;counter++){
//    vector[0] = npc_x[counter] - mouseX; //Vx = NPCx - PCx
//    vector[1] = npc_y[counter] - mouseY; //Vy = NPCy - PCy
//    magnitude = sqrt(vector[0] * vector[0] + vector[1] * vector[1]); // = distance
//    // When are you having collisions?ç
//    if (magnitude < radius_npcs + radius_pc){
//    println("I just collided with ", counter);
//    } else println("I'm not colliding");
//  }
//}
