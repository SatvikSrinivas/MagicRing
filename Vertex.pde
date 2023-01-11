
class Vertex {

  int n;
  float x, y;

  public void instantiate (int n, float x, float y) {
    this.n = n;
    this.x = getX(x);
    this.y = getY(y);
  }

  public Vertex (int n, float x, float y) {
    instantiate(n, x, y);
  }

  public Vertex (int n, Vector v) {
    instantiate(n, v.x, v.y);
  }

  public void draw() {
    fill(0, 153, 255);
    stroke(255);
    strokeWeight(radius/20);
    circle(x, y, radius);
    setTextSize(0.6 * radius);
    fill(255);
    String text = ""+n;
    text(text, x - textWidth(text)/ 2, y + textHeight(text)/ 2);
  }

  public String toString() {
    return "<"+invX(x)+", "+invY(y)+">";
  }
}

float textSize;
void setTextSize(float size) {
  textSize = size;
  textSize(textSize);
}

float textHeight(String text) {
  PFont font = createFont("Arial", textSize, true);
  textFont(font);
  float minY = Float.MAX_VALUE;
  float maxY = Float.NEGATIVE_INFINITY;
  for (Character c : text.toCharArray()) {
    PShape character = font.getShape(c); // create character vector
    for (int i = 0; i < character.getVertexCount(); i++) {
      minY = min(character.getVertex(i).y, minY);
      maxY = max(character.getVertex(i).y, maxY);
    }
  }
  return maxY - minY;
}
