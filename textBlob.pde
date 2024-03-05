class TextBlob {
  Textfield textField;
  boolean isDragging = false;

  void tBlob(color boja, String velicina, String font, DrawArea area) {
    if (mousePressed) {
      if (textField == null || !textField.isFocus()) {
        if (mouseX < area.left || (mouseX + 200) > area.right || mouseY < area.up || (mouseY + 30) > area.down) {
          return;
        } else {
          createTextField(boja, velicina, font, mouseX, mouseY);
        }
      }
    }
  }

  void createTextField(color boja, String velicina, String font, int x, int y) {
    if (textField != null) {
      textField.setColor(color(0)); // reset previous textfield color
    }
    int size = 12; // default font size
    if (velicina.equals("medium")) {
      size = 15;
    } else if (velicina.equals("large")) {
      size = 18;
    }
    textField = cp5.addTextfield("textfield")
      .setPosition(x, y)
      .setSize(200, 30)
      .setColor(boja)
      .setColorBackground(color(255))
      .setColorForeground(color(255))
      .setAutoClear(false)
      .setColorActive(color(150))
      .setFont(createFont(font, size))
      .setFocus(true); // Set border color to transparent
  }
}
