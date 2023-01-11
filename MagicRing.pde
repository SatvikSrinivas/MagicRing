
class MagicRing {

  int n;
  Vertex[] verticies;
  float thetaDecrement;

  public MagicRing(int n) {
    this.n = n;
    thetaDecrement = 2 * PI / n;
    setVerticies();
  }

  public void setVerticies() {
    verticies = new Vertex[2 * n  + 1];
    float theta = PI/2;
    for (int i = n + 1; i < verticies.length; i++) {
      verticies[i] = new Vertex(i, 2*radius*cos(theta), 2*radius*sin(theta));
      theta -= thetaDecrement;
    }

    Vertex one, two;
    Vector v1, v2, v;
    for (int i = 1; i < n; i++) {
      one = verticies[i + n];
      two = verticies[i + n + 1];
      v1 = new Vector (invX(one.x), invY(one.y));
      v2 = new Vector (invX(two.x), invY(two.y));
      v = v1.sum(v1).diff(v2);
      verticies[i] = new Vertex(i, v.x, v.y);
    }
    one = verticies[2 * n];
    two = verticies[n + 1];
    v1 = new Vector (invX(one.x), invY(one.y));
    v2 = new Vector (invX(two.x), invY(two.y));
    v = v1.sum(v1).diff(v2);
    verticies[n] = new Vertex(n, v.x, v.y);
  }

  public void drawLines() {
    stroke(255);
    strokeWeight(2);
    for (int i = 1; i <= n - 1; i++)
      lineSegment(verticies[i], verticies[i + n + 1]);
    lineSegment(verticies[n], verticies[n + 1]);
  }

  public void drawVerticies() {
    for (Vertex v : verticies)
      if (v != null)
        v.draw();
  }

  // special case ONLY works for pent if it sees a 0 assumes the 0 is from 10
  public void set(long order) {
    for (int i = 2 * n; i > 0; i--) {
      verticies[i].n = (int)(order % 10);
      if (verticies[i].n == 0) {
        verticies[i].n = 10;
        order /= 10;
      }
      order /= 10;
    }
  }

  public long order(int seed) {
    String order = "";
    // creating an array of nums to choose from
    int[] nums = new int[2 * n];
    for (int i = 0; i < nums.length; i++)
      nums[i] = i + 1;
    int temp, k;
    long fac = factorial(nums.length - 1);
    // following the order determined by the seed to choose from nums
    for (int i = nums.length - 1; i >= 0; i--) {
      temp = (int)(seed / fac);
      seed -= temp * fac;
      k = -1;
      for (int j = 0; j < nums.length; j++) {
        if (nums[j] != 0)
          k++;
        if (k == temp) {
          temp = j;
          break;
        }
      }
      nums[temp] = 0;
      order += (temp + 1);
      if (i != 0)
        fac /= i;
    }
    return Long.parseLong(order);
  }

  public void printMagicalList() {
    Long l;
    String s;
    for (int i = 0; i < factorial(2 * n); i++)
      if (isMagical(i)) {
        l = order(i);
        s = solutionString(l);
        if (s.length() == 16)
          println("["+i+"] "+s + " -> " + solution(l));
      }
  }

  public String solution(long order) {
    String solution = "";
    set(order);
    for (int i = 1; i < n; i++)
      solution += verticies[i].n + "," + verticies[n + i].n + "," + verticies[n + i + 1].n +"; ";
    solution += verticies[n].n + "," + verticies[verticies.length - 1].n + "," + verticies[n + 1].n;
    return solution;
  }

  public String solutionString(long order) {
    String solutionString = "";
    set(order);
    for (int i = 1; i < n; i++)
      solutionString += "" + verticies[i].n + verticies[n + i].n + verticies[n + i + 1].n;
    solutionString += "" + verticies[n].n + verticies[verticies.length - 1].n + verticies[n + 1].n;
    return solutionString;
  }

  public boolean isMagical(int seed) {
    set(order(seed));
    int magicalSum = verticies[1].n + verticies[n + 1].n + verticies[n + 2].n;
    for (int i = 2; i < n; i++)
      if (verticies[i].n + verticies[n + i].n + verticies[n + i + 1].n != magicalSum)
        return false;
    return verticies[n].n + verticies[verticies.length - 1].n + verticies[n + 1].n == magicalSum;
  }

  public void draw() {
    drawLines();
    drawVerticies();
  }
}

long factorial (int n) {
  if (n == 0)
    return 1;
  return n * factorial(n - 1);
}
