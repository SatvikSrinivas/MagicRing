
int n = 5;
float radius;
MagicRing m, tri, pent;

void setup() {
  fullScreen();
  defaultBounds();
  radius = n * 15;
  m = new MagicRing(n);
  tri = new MagicRing(3);
  pent = new MagicRing(5);
  //pent.printMagicalList();
  pent.set(pent.order(2869635));
}

boolean draw = true;

void draw() {
  if (!draw)
    return;
  background(0);
  //m.draw();
  //tri.draw();
  pent.draw();
}

void reset() {
  radius = (int)(80/(1+Math.pow(Math.E, -n)));
  m = new MagicRing(n);
}

void keyPressed() {
  switch (keyCode) {
  case UP :
    if (n == 8)
      return;
    n++;
    break;
  case DOWN:
    if (n == 3)
      return;
    n--;
    break;
  }
  reset();
}
