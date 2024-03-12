//HAY Q ARREGLAR ESTO QUE PETA CON LOS PLAYERS

////Funcion para cambiar de input mouse a inputs de teclado
boolean mouseCommandActivated = true;
void SwitchCommandsMovement(){
  if (keyPressed){
    if(key == 'K' || key == 'k'){
      mouseCommandActivated = false;
      }
      
    if(key == 'M' || key == 'm'){
      mouseCommandActivated = true; 
      }
    
    //Cambio de los comandos según el booleano
    if(!mouseCommandActivated){
    //if(keyPressed(){
    if (key=='w' || key=='W')
      player.y+=4;
   if (key=='a' || key=='A')
     player.y-=4;
    if (key=='s' || key=='S')
      player.x-=4;
    if (key=='d' || key=='D')
      player.x+=4;    
    }
     
    } 
    if(mouseCommandActivated){ 
    player.x = mouseX;
    player.y = mouseY;
  }
}
