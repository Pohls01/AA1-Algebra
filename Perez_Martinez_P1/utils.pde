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
