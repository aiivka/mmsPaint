PImage spray; 

void drawSprayCanPreview(float x, float y) {
    image(spray, x, y, 50, 50);
}

void drawSprayCircle(float x, float y, int radius, int density) { // raidus could be fixed value but this allows new feature
  if (mousePressed){
    generatedImage.beginDraw();
    generatedImage.stroke(red);
    generatedImage.strokeWeight(2);
  
    for (int i = 0; i < density; i++) { 
      float randomAngle = random(TWO_PI);
      float randomDistance = random(radius);
  
      float offsetX = cos(randomAngle) * randomDistance;
      float offsetY = sin(randomAngle) * randomDistance;
  
      float sprayX = x + offsetX; //105, 100, 750, 450
      float sprayY = y + offsetY;
  
      drawDot(generatedImage, sprayX - 105, sprayY - 100, 2);
    }
  
    generatedImage.endDraw();
  }
}

void drawDot(PGraphics pg, float x, float y, float diameter) {
  pg.beginDraw();
  pg.fill(firstChosenColorButton.rectColor); // selected color
  pg.noStroke();
  pg.ellipse(x, y, diameter, diameter);
  pg.endDraw();
}
