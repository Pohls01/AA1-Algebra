class Vector2{
  float x;
  float y;
}

char charUpper(char c){
  if(c >= 'a' && c <= 'z'){
    c += 'a' - 'A';
  }
  return c;
}

int getQuadrant(PVector position) {
  if (position.x<width/2.0) {
    if (position.y<height/2.0) return 1;
    else return 4;
  } else {
    if (position.y<height/2.0) return 2;
    else return 3;
  }
}
