class Can {
  void colorCan(color c, DrawArea area) {
    if (mousePressed) {
      loadPixels();
      color currentColor = pixels[mouseY * width + mouseX];
      coloring(c, currentColor, int(mouseX), int(mouseY), area);
      updatePixels();
    }
  }
  
  void coloring(color c, color currentColor, int xMouse, int yMouse, DrawArea area) {
    return;
    /*if (yMouse > area.down || yMouse < area.up || xMouse > area.right || xMouse < area.left) return;
    if (currentColor != pixels[yMouse * width + xMouse]) return;
    pixels[yMouse * width + xMouse] = c;
    coloring(c, currentColor, xMouse - 1, yMouse, area);
    coloring(c, currentColor, xMouse, yMouse - 1, area);
    coloring(c, currentColor, xMouse + 1, yMouse, area);
    coloring(c, currentColor, xMouse, yMouse + 1, area);*/
  }
}
