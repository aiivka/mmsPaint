import java.utils.*;

ArrayList<PVector> dots = new ArrayList<PVector>();

class pencil {
  
  void pen(int c, int w) {
    stroke(c);
    strokeWeight(w);
    ellipse(pmouseX, pmouseY, mouseX, mouseY);
  }
  
  void magicPen(int w) {
  if (mousePressed) {
    dots.add(new PVector(mouseX, mouseY));
    drawDots(w);
  } else {
    // mice duplikate tocaka
    PVector point;
    for (int i = dots.size() - 1; i > 0; i--) {
      PVector point1 = dots.get(i), point2 = dots.get(i - 1);
      if ((point1.x == point2.x && point1.y == point2.y) || i % 2 == 1) {
        point = dots.get(i);
        remDot(point.x, point.y, w);
        dots.remove(i);
      }
    }
    if (dots.size() < 5) return;
    point = dots.get(0);
    remDot(point.x, point.y, w);
    point = dots.get(1);
    remDot(point.x, point.y, w);
    for (int i = dots.size() - 3; i >= 2; i--) {
      PVector point1 = dots.get(i - 2), point2 = dots.get(i - 1);
      PVector point3 = dots.get(i + 2), point4 = dots.get(i + 1);
      point = dots.get(i);
      float slope1 = (point2.y - point1.y) / (point2.x - point1.x);
      float slope2 = (point4.y - point3.y) / (point4.x - point3.x);
      float slopeX1 = (point2.y - point.y) / (point2.x - point.x);
      float slopeX2 = (point3.y - point.y) / (point3.x - point.x);
      remDot(point.x, point.y, w);
      if (abs(1 - abs(slope1 / slope2)) < 0.1) {
        if (abs(1 - abs(slopeX1 / slope1)) >= 0.1 || abs(1 - abs(slopeX2 / slope2)) >= 0.1) {
          dots.remove(i);
        }
      }
    }
    point = dots.get(dots.size() - 1);
    remDot(point.x, point.y, w);
    point = dots.get(dots.size() - 2);
    remDot(point.x, point.y, w);
    for (int i = 1; i < dots.size(); i++) {
      int r = int(random(255) + 1);
      int g = int(random(255) + 1);
      int b = int(random(255) + 1);
      stroke(r, g, b);
      strokeWeight(w);
      PVector point2 = dots.get(i), point1 = dots.get(i - 1);
      line(point1.x, point1.y, point2.x, point2.y);
    }
    dots.clear(); 
  }
}

  void drawDots(int w) {
    fill(0);
    noStroke(); // Turn off outline
    ellipse(mouseX, mouseY, w+1, w+1); // Draw a circle at mouse position
  }
  
  void remDot(float x, float y, int w) {
    fill(255); // Set fill color to black
    noStroke(); // Turn off outline
    ellipse(x, y, w + 1, w + 1);
  }
}
