
class Vector2{
    float x;
    float y;
}


char charUpper(char c) {
    if (c >= 'a' && c <= 'z') {
        c += 'a' - 'A';
    }
    return c;
}

// Funcion para obtener el cuadrante de una posicion
int getQuadrant(PVector position) {
    if (position.x < width / 2.0) {
        if (position.y < height / 2.0) return 1;
        else return 4;
    } else {
        if (position.y < height / 2.0) return 2;
        else return 3;
    }
}

//Calculo de colisiones en base a la posicion y el tamaño de los objetos
boolean calculateCollisions(PVector pos, float colSize) {
    // Evaluate collisions
    PVector min_pc = new PVector(pos.x - colSize, pos.y - colSize);
    PVector max_pc = new PVector(pos.x + colSize, pos.y + colSize);
    int quadrant = getQuadrant(pos);
    for (int i = 0; i < circleObstacles.length;i++) {
        if (circleObstacles[i].obsQuadrant == quadrant) {
            if (sqrt(pow(circleObstacles[i].position.x - pos.x,2) + pow(circleObstacles[i].position.y - pos.y,2)) <= circleObstacles[i].size.x + colSize) {
                return true;
            }
        }
    }
    for (int i = 0; i < rectObstacles.length;i++) {
        if (rectObstacles[i].obsQuadrant == quadrant) {
            if (!((max_pc.x < rectObstacles[i].min_obs.x) || (max_pc.y<rectObstacles[i].min_obs.y) || (rectObstacles[i].max_obs.x<min_pc.x) || (rectObstacles[i].max_obs.y<min_pc.y))) {
                return true;
            }
        }
    }
    return false;
}


int GetRandomSign() {
    float tempInt = random( -1,1);
    if (tempInt < 0) return - 1;
    else return 1;
}

// Colisiones de enemigos
boolean enemyCollide(PVector pos, float colSize) {
    int quadrant = getQuadrant(pos);
    for (int i = 0; i < pEnemies.size();i++) {
        PassiveEnemy enemy = pEnemies.get(i);
        if (quadrant == getQuadrant(enemy.position)) {
            if (sqrt(pow(enemy.position.x - pos.x,2) + pow(enemy.position.y - pos.y,2)) <= enemy.enemyColSize + colSize) {
                return true;
            }
        }
    }
    for (int i = 0; i < cEnemies.size();i++) {
        ChasingEnemy enemy = cEnemies.get(i);
        if (quadrant == getQuadrant(enemy.position)) {
            if (sqrt(pow(enemy.position.x - pos.x,2) + pow(enemy.position.y - pos.y,2)) <= enemy.enemyColSize + colSize) {
                return true;
            }
        }
    }
    return false;
}

//Colisiones entre entidades de objetos (Player, PNJ, Enemigos)
boolean collideEntities(PVector pos1, float colSize1, PVector pos2, float colSize2) {
    if (sqrt(pow(pos1.x - pos2.x,2) + pow(pos1.y - pos2.y,2)) <= colSize1 + colSize2) {
        return true;
    }
    return false;
}

void emptyArrayList(ArrayList list) {
    for (int i = list.size() - 1; i >= 0; i--) {
        list.remove(i);
    }
}