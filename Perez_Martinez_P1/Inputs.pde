boolean mouseCommandActivated = true;

Button startButton;
boolean keyUp, keyDown, keyLeft, keyRight;

//Función para inizializar elementos relacionados con inputs
void setupInputs() {
    //Se asignan los valores del botón de inicio (posición, tamaño, texto y colores)
    startButton = new Button();
    startButton.x = width / 2;
    startButton.y = height / 2 + 150;
    startButton.sizeX = 350;
    startButton.sizeY = 80;
    startButton.butText = "START GAME";
    startButton.hiTextCol = 0;
}
//Función que se llama al presionar una tecla
void keyPressed() {
    //Si estamos en la escena inicial y pulsamos un número, se añade al número de enemigos
    if (inStart) {
        if (keyChecker(key) == "NUM") {
            //Paraañadir un dígito al final de un número, se multiplica por 10 y se suma el dígito correspondiente a la tecla pulsada
            N = (N * 10) + (int(key) - '0');
            //Se limita el número de enemigos máximo a 100
            if (N > 100) {N = 100;}
        }
        //Sise pulsa la tecla de retroceso, se divide el número entre 10, eliminando la última cifra
        if (key == BACKSPACE) {
            N /= 10;
        }
    }
    //Comprobación de los comandos activados
    else{
        if (key == 'K' || key == 'k') {
            mouseCommandActivated = false;
        }
        
        if (key == 'M' || key == 'm') {
            mouseCommandActivated = true; 
        }
        
        if (key == 'B' || key == 'b') {
            inBoss = true; 
            bulletActive = true;
            BossSetUp();
        }
        if (key == 'R' || key == 'r') {
            inStart = true; 
        }
        
        if (key ==  'w' || key ==  'W')
            keyUp = true;
        if (key ==  's' || key ==  'S')
            keyDown = true;
        if (key ==  'a' || key ==  'A')
            keyLeft = true;
        if (key ==  'd' || key ==  'D')
            keyRight = true;
    }
}
void keyReleased() {
    if (key ==  'w' || key ==  'W')
        keyUp = false;
    if (key ==  's' || key ==  'S')
        keyDown = false;
    if (key ==  'a' || key ==  'A')
        keyLeft = false;
    if (key ==  'd' || key ==  'D')
        keyRight = false;
}

//Función que sellama al hacer clic con el ratón
void mousePressed() {
    //Si estamos en la escena inicial y hacemos clic sobre el botón de inicio, se desactiva la escena inicial
    if (inStart) {
        if (startButton.overButton()) {
            inStart = false;
            gameSetup();
        }
    }
}

//Clase que define todos los elementos que puede tener un botón, definiendo valores por defecto para algunos parámetros
class Button{
    color butCol = 0;
    color highlightCol = 155;
    int x;
    int y;
    int sizeX;
    int sizeY;
    int cornerRadius = 15;
    
    String butText;
    color textCol = 255;
    color hiTextCol = 0;
    int txtSize = 50;
    
    //Esta función devuelve un booleano true si el cursor está sobre el botón y false si no es el caso
    boolean overButton() {
        if (mouseX >= x - sizeX / 2 && mouseX <= x + sizeX / 2 && 
            mouseY >= y - sizeY / 2 && mouseY <= y + sizeY / 2) {
            return true;
        } 
        else{
            return false;
        }
    }
    
    //Esta función dibuja el botón, teniendo en cuenta los parámetros asignados, y si el cursor está sobre el o no para resaltarlo
    void drawButton() {
        color tempTextCol;
        rectMode(CENTER);
        if (overButton()) {
            fill(butCol);
            rect(x, y, sizeX + 10, sizeY + 10, 20);
            fill(highlightCol);
            tempTextCol = hiTextCol;
        }
        else{
            fill(butCol);
            tempTextCol = textCol;
        }
        stroke(255);
        rect(x, y, sizeX, sizeY, 15);
        if (butText != null && !butText.isEmpty()) {
            textSize(txtSize);
            textAlign(CENTER, CENTER);
            fill(tempTextCol);
            text(butText, x, y);
        }
    }
}

//Esta función procesa la tecla recibida en el keyPressed e indica de qué tipo de tecla se trata
String keyChecker(char c) {
    if (c >= '0' && c <= '9') {
        return "NUM";
    }
    else if ((c >=  'A' && c <=  'Z') || (c >= 'a' && c <= 'z')) {
        return "LET";
    }
    else {
        return "OTH";
    }
}
