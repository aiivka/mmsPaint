import java.util.ArrayList;

ArrayList<PVector> dots = new ArrayList<PVector>();

class Pencil {
  float r, g, b;
  
  void pen(int c, int w) {
    stroke(c);
    strokeWeight(w);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  
  void magicPen(int w) {
    if (mousePressed) {
      dots.add(new PVector(mouseX, mouseY));
      drawDots(w);
      r = random(255); g = random(255); b = random(255);
    } else {
      // remove all duplicates of points and dots
      PVector point1, point2;
      for (int i = dots.size() - 1; i > 0; i--) {
        point1 = dots.get(i); point2 = dots.get(i - 1);
        if ((point1.x == point2.x && point1.y == point2.y)) {
          remDot(point1.x, point1.y, w);
          dots.remove(i);
        }
      }
  
      float r2 = random(255), g2 = random(255), b2 = random(255);  
      float rx = (r2 - r)/10, gx = (g2 - g)/10, bx = (b2 - b)/10;
      for (int i = 0; i < dots.size() - 1; i++) {
        stroke(r, g, b);
        print("red: " + r + " green: " + g + " blue: " + b);
        strokeWeight(w);
        point1 = dots.get(i); point2 = dots.get(i + 1);
        line(point1.x, point1.y, point2.x, point2.y);
        r += rx;
        g += gx;
        b += bx;
        if (i % 10 == 9) {
          r2 = random(255); g2 = random(255); b2 = random(255); 
          rx = (r2 - r)/10; gx = (g2 - g)/10; bx = (b2 - b)/10;
        }
      }
      dots.clear(); 
    }
  }
  
  void gradientPen(int w, color c, color c2) {
    if (mousePressed) {
      dots.add(new PVector(mouseX, mouseY));
      drawDots(w);
    } else {
      // remove all duplicates of points and dots
      PVector point1, point2;
      for (int i = dots.size() - 1; i > 0; i--) {
        point1 = dots.get(i); point2 = dots.get(i - 1);
        if ((point1.x == point2.x && point1.y == point2.y)) {
          remDot(point1.x, point1.y, w);
          dots.remove(i);
        }
      }
  
      r = red(c); g = green(c); b = blue(c);
      float r2 = red(c2), g2 = green(c2), b2 = blue(c2);
      float rx = (r2 - r)/dots.size(), gx = (g2 - g)/dots.size(), bx = (b2 - b)/dots.size();
      for (int i = 0; i < dots.size() - 1; i++) {
        stroke(r, g, b);
        print("red: " + r + " green: " + g + " blue: " + b);
        strokeWeight(w);
        point1 = dots.get(i); point2 = dots.get(i + 1);
        line(point1.x, point1.y, point2.x, point2.y);
        r += rx;
        g += gx;
        b += bx;
      }
      dots.clear(); 
    }
  }
  
  
  void drawDots(int w) {
    fill(0);
    noStroke(); // Turn off outline
    ellipse(mouseX, mouseY, w-1, w-1); // Draw a circle at mouse position
  }
  
  void remDot(float x, float y, int w) {
    fill(255); // Set fill color to black
    noStroke(); // Turn off outline
    ellipse(x, y, w, w);
  }
}
