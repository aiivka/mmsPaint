void fileSelected(File selection) {
  if(selection != null) {
    for (Gumb toolButton : toolButtons) {
      toolButton.unSelectedVisualUpdate();
      
    }
    if (importSelected) {
  
      println("import -User selected " + selection.getAbsolutePath());
      loadedImage = loadImage(selection.getAbsolutePath()); // user image does not need to be inside data folder
  
  
      float widthRatio = 750 / loadedImage.width;
      float heightRatio = 450 / loadedImage.height;
      resizedImageScale = min(widthRatio, heightRatio);
  
      int resizedImageWidth = int(loadedImage.width * resizedImageScale);
      int resizedImageHeight = int(loadedImage.height * resizedImageScale);
  
      resizedImportedImage = loadedImage.copy();
      resizedImportedImage.resize(resizedImageWidth, resizedImageHeight);
     
      importButton.dodajSliku(selection.getAbsolutePath());
      
      importButton.nacrtajSliku();
  
      importedImagePositionSelected = true;
      importSelected = false;
    } else if (exportSelected) {
      PImage generatedImage = get(105, 100, 750, 450); // screenshot of canvas
  
      String filePath = selection.getAbsolutePath();
      String filePathLowerCase = filePath.toLowerCase();
      if (!filePathLowerCase.endsWith(".png") && !filePathLowerCase.endsWith(".jpg") && !filePathLowerCase.endsWith(".jpeg")) {
        filePath += ".png"; // default save as png, if not provided, image is not saved, could add gif (gifAnimation library) as part of future improvements
      }
  
      generatedImage.save(filePath);
      println("export - User selected: " + filePath);
      exportSelected = false;
    }
  }
}
