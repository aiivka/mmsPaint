// created to save imported images and its positions to draw
ArrayList<Image> importedImagesArray = new ArrayList<Image>();

class Image {
  PImage image;
  float startX = 105, startY = 100;
  float scale;
    
  Image(PImage image_) {
    image = image_;
  }
  
  Image(PImage image_, float startX_, float startY_) {
    image = image_;
    startX = startX_;
    startY = startY_;
  }

  void setScale(float newScale) {
    this.scale = newScale;
    this.image.resize(int(image.width * scale), int(image.height * scale));
  }
  
  void drawFromStart(){
    image(image, startX, startY);
  }
}
