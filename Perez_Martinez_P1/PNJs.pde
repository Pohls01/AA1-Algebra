float xNPC = width / 2;
float yNPC = height / 2;
float xNPC2 = width / 2;
float yNPC2 = height / 2;
float alpha = 0.075;
float angleNPC1;
float angleNPC2;

//Pintar los NPCs
void drawNPCs(){
  //Obtenemos el ángulo entre el PC y el NPC1 mediante la arco tangente del vector que los une
  //Se utilizan valores absolutos porque la función atan() solo devuelve valores entre -PI/2 y PI/2
  //Más adelante se comprobará la posición relativa para añadir el signo correspondiente
  angleNPC1 = atan(abs(mouseY-yNPC)/abs(mouseX-xNPC));
  
  //Hacemos que el NPC1 siga al PC a cierta velocidad controlada por el parámetro alpha
  //Para que le siga a cierta distancia (un radio de 150px), se aplica esta distancia proporcionalmente a cada eje con respecto al ángulo obtenido anteriormente
  //Se utiliza el coseno para la componente horizontal y el seno para la vertical
  //Se utiliza la función signum() para aplicar un signo positivo o negativo al offset dependiendo de la posición relativa del NPC1 con respecto al PC
  xNPC = ((1-alpha) * xNPC + alpha * (mouseX - signum(mouseX-xNPC)* 150 *cos(angleNPC1)));
  yNPC = ((1-alpha) * yNPC + alpha * (mouseY - signum(mouseY-yNPC)* 150 *sin(angleNPC1)));
  
  //Se dibuja el NPC1
  fill(#C78DA3);
  ellipse(xNPC, yNPC, 20, 20);
  
  //Se obtiene el ángulo entre el NPC1 y el NPC2
  angleNPC2 = atan(abs(yNPC-yNPC2)/abs(xNPC-xNPC2));

  //Se utiliza el mismo método que en el caso del NPC1 para hacer que el NPC2 siga al NPC1 a una distancia de 200px
  xNPC2 = (1-alpha) * xNPC2 + alpha * (xNPC - signum(xNPC-xNPC2)*150*cos(angleNPC2));
  yNPC2 = (1-alpha) * yNPC2 + alpha * (yNPC - signum(yNPC-yNPC2)*150*sin(angleNPC2));
  
  //Se dibuja el NPC2
  fill(#FBD2C1);
  ellipse(xNPC2, yNPC2, 20, 20);
}

//La función signum devuelve +1 o -1 en función del signo del número pasado como parámetro. Devuelve 0 si el número es 0
int signum(float number){
  if (number > 0) return 1;
  if (number < 0) return -1;
  return 0;
}
