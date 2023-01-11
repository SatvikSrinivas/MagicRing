
class Vector {

  float x, y;

  Vector (float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public Vector sum(Vector v) {
    return new Vector (x + v.x, y + v.y);
  }
  
  public Vector diff(Vector v) {
    return new Vector (x - v.x, y - v.y);
  }
  
}
