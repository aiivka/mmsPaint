import controlP5.*; // Koristimo Textfield iz biblioteke controlC5. //<>// //<>// //<>// //<>//
import ddf.minim.*; // Koristimo biblioteku Minim za dodavanje zvuka

ControlP5 cp5;

Pencil pencil = new Pencil();
Can can = new Can();
Oblici oblici = new Oblici();
TextBlob textBlob = new TextBlob();

PGraphics helpScreen;
boolean isTyping = false, isShape = false;

String tool;

PFont font;
int numGenImages = 0;
boolean isSaveVisible = false;
int saveTimeStart, saveTimeStop = millis();


// ------------boje -------------

color black = color(0,0,0);              color grey = color (190,190,190);
color greyD = color (200,199,201);       color darkRed = color(140, 59, 59);
color red = color(185, 59, 59);          color orange = color (255,165,0);
color yellow = color(255, 255, 0);       color green = color (0,128,0);
color turquoise = color( 173,234,234);   color steelBlue = color(35,107,142);
color marine = color(30, 203, 225);      color blue = color(58, 39, 216);
color darkPurple = color(85,26,139);     color purple = color(58, 39, 216);
color white = color (255, 255, 255);     color lightGrey = color(205,201,201);
color brown = color(139,101,8);          color copper = color(133,99,99);
color spicyPink = color(255,28,174);     color gold = color(255,215,0);
color beige = color(255,246,143);        color lime = color(0,255,0);
color violet = color(238,130,238);       color redRed = color(255,0,0);
color mistyRose = color(255,228,225);    color hotPink = color(255,105,180);
color coral = color(255,114,86);         color peachPuff = color(255,218,185);
color springGreen = color(0,255,127);    color stateBlue = color(131,111,255);

//---------------------------------

color colorRect = color(int(random(255)), int(random(255)), int(random(255)));

Gumb b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15; // shapeButtons
Gumb p1, p2, p3, p4, p5, p6, p7, p8, p9; // toolButtons
Gumb s1, s2, s3; //sizeButtons
Gumb f1, f2, f3; //fontButtons

Gumb firstChosenColorButton = new Gumb(0, 595, black);
Gumb secondChosenColorButton = new Gumb(0, 645, white);
Gumb colorSelection = firstChosenColorButton;
Gumb pressedToolButton;
Gumb pressedShapeButton;
Gumb pressedSizeButton;
Gumb pressedFontButton;

Grid_ toolGrid = new Grid_(5, 2);
Gumb[] toolButtons= { p1 = new Gumb("pen"), p2 = new Gumb("magicPen"), p5 = new Gumb("text"), p3 = new Gumb("can"),
                      p6 = new Gumb("gradientPen"), p7 = new Gumb("eraser"), p4 = new Gumb("shapes"), p8 = new Gumb("photo"), p9 = new Gumb("spray") };

Grid_ colorGrid = new Grid_(2, 14); // [2][14]
Gumb[] colorButtons = { new Gumb(30, 30, 30, 30, green), new Gumb(30, 30, 30, 30, grey), new Gumb(30, 30, 30, 30, darkRed), new Gumb(30, 30, 30, 30, red), 
new Gumb(30, 30, 30, 30, orange), new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, turquoise), 
new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, blue), new Gumb(30, 30, 30, 30, white),new Gumb(30, 30, 30, 30, black), new Gumb(30, 30, 30, 30, lightGrey),
new Gumb(30, 30, 30, 30, brown), new Gumb(30, 30, 30, 30, spicyPink), new Gumb(30, 30, 30, 30, gold), new Gumb(30, 30, 30, 30, beige),
new Gumb(30, 30, 30, 30, lime), new Gumb(30, 30, 30, 30, copper), new Gumb(30, 30, 30, 30, steelBlue), new Gumb(30, 30, 30, 30, violet),
new Gumb(30, 30, 30, 30, redRed), new Gumb(30, 30, 30, 30, mistyRose), new Gumb(30, 30, 30, 30, hotPink), new Gumb(30, 30, 30, 30, coral),
new Gumb(30, 30, 30, 30, peachPuff), new Gumb(30, 30, 30, 30, springGreen), new Gumb(30, 30, 30, 30, stateBlue),new Gumb(30, 30, 30, 30, darkPurple),};


Grid_ sizeGrid = new Grid_(1, 3);
Gumb[] sizeButtons = {s1= new Gumb("small", grey), s2= new Gumb("medium", grey), s3=new Gumb("large", grey)};

Grid_ fontGrid = new Grid_(1, 3);
Gumb[] fontButtons ={f1 = new Gumb("Impact", grey), f2= new Gumb("Courier New", grey), f3= new Gumb("Brush Script MT", grey)};

Grid_ shapeGrid = new Grid_(2, 8);
Gumb[] shapeButtons = { b1 = new Gumb("Line", grey), b2 = new Gumb("Circle", grey), b3 = new Gumb("Rectangle", grey), b4 = new Gumb("Star", grey),
                        b5 = new Gumb("Heart", grey), b6 = new Gumb("Triangle", grey), b7 = new Gumb("Rhombus", grey), b8 = new Gumb("Pentagon",grey),
                        b9 = new Gumb("MultiStar", grey), b10 = new Gumb("SmallStar", grey), b11=  new Gumb("OvalRect", grey), b12 = new Gumb("ArrowL", grey), 
                        b13 = new Gumb("ArrowR", grey), b14 = new Gumb("ArrowU", grey), b15 = new Gumb("ArrowD", grey)
                      };
Grid_ photoGrid = new Grid_(2, 2);
Gumb houseButton = new Gumb("House");
Gumb carButton = new Gumb("Car");
Gumb butterflyButton = new Gumb("Butterfly");
Gumb catButton = new Gumb("Cat");

Gumb[] photoButtons = {houseButton, carButton, butterflyButton,catButton };

////image import, export
Grid_ importExportGrid = new Grid_(1, 2);
Gumb importButton = new Gumb("Import");
Gumb exportButton = new Gumb("Export");
Gumb[] importExportArray = {importButton, exportButton};
boolean importSelected = false;
boolean exportSelected = false;

boolean importedImagePositionSelected = false;

PImage loadedImage, resizedImportedImage;
float resizedImageScale;
PGraphics generatedImage;

class DrawArea {
  int sizeX = 750, sizeY = 450;
  int left = 105, right = 105 + sizeX, up = 100, down = 100 + sizeY;
}

DrawArea area = new DrawArea();

PShape house, car, butterfly, cat;
PShape resizedImportedSVG;

float resizedSVGImageScale;
boolean SVGImagePositionSelected = false;

boolean photoSelected = false, houseSelected = false, carSelected = false ; 
boolean butterflySelected=false, catSelected=false;

color pozadina = color(203,203,204);

 
void setup() {
    size(1050, 750);
    rect(area.left, area.up, area.sizeX, area.sizeY); // white space for drawing
    
    toolGrid.addButtons(toolButtons, 0, 0, 50, 50);
    colorGrid.addButtons(colorButtons, 50, 605, 30, 30);
    photoGrid.addButtons(photoButtons,900, 100, 50, 50 );
    shapeGrid.addButtons(shapeButtons, 200, 5, 45, 45);
    sizeGrid.addButtons(sizeButtons, 50, 680, 95, 50);
    fontGrid.addButtons(fontButtons, 620, 20, 95, 115);
    importExportGrid.addButtons(importExportArray, 900, 0, 50, 50);
    
    cp5 = new ControlP5(this);
    font = loadFont("Hiragino15.vlw");
    setupScaleSlider();
    
    // ------- random color sliders -----------
    cp5.addSlider("red")
     .setPosition(550, 600)
     .setWidth(200)
     .setHeight(20)
     .setRange(0, 255)
     .setValue(red(colorRect))
     .setColorForeground(color(200, 0, 100));
  
  cp5.addSlider("green")
     .setPosition(550, 650)
     .setWidth(200)
     .setHeight(20)
     .setRange(0, 255)
     .setValue(green(colorRect))
     .setColorForeground(color(100, 200, 0));
  
  cp5.addSlider("blue")
     .setPosition(550, 700)
     .setWidth(200)
     .setHeight(20)
     .setRange(0, 255)
     .setValue(blue(colorRect))
     .setColorForeground(color(0, 100, 200));
    
    colorSelection.selectedVisualUpdate();
    
    house=loadShape("kuca.svg");
    car=loadShape("car.svg");
    butterfly=loadShape("butterfly.svg");
    cat=loadShape("cat.svg");

//---------- shape button pictures -----------------------
    b1.dodajSliku ("line.png");         b9.dodajSliku("multiStar.png");
    b2.dodajSliku("circle.png");        b10.dodajSliku("smallStar.png");
    b3.dodajSliku("rectangle.png");     b11.dodajSliku("ovalRect.png");
    b4.dodajSliku("star.png");          b12.dodajSliku("arrowL.png");
    b5.dodajSliku("heart.png");         b13.dodajSliku("arrowR.png");
    b6.dodajSliku("triangle.png");      b14.dodajSliku("arrowU.png");
    b7.dodajSliku("rhombus.png");       b15.dodajSliku("arrowD.png");
    b8.dodajSliku("pentagon.png");
    
//----------- tool button pictures -------------------------
    p1.dodajSliku("pen.png");
    p2.dodajSliku("magicPen.png");
    p3.dodajSliku("bucket.png");
    p4.dodajSliku("shapes.png");
    p5.dodajSliku("text.png");
    p6.dodajSliku("gradientPen.png");
    p7.dodajSliku("eraser.png");
    p8.dodajSliku("picture.png");
    p9.dodajSliku("spray.png");
    
 //-------- photo button pictures-------------------------
   houseButton.dodajSliku("house.png");
   carButton.dodajSliku("car.png");
   butterflyButton.dodajSliku("butterfly.png");
   catButton.dodajSliku("cat.png");
 
 //---------size button pictures----------------------------
   s1.dodajSliku("s.png");
   s2.dodajSliku("m.png");
   s3.dodajSliku("l.png");
 
 //---------font button pictures-------------------------
   f1.dodajSliku("impact.png");
   f2.dodajSliku("courier.png");
   f3.dodajSliku("brush.png");

 //---------import button pictures
 importButton.dodajSliku("import.png");
 exportButton.dodajSliku("export.png");
 
 spray = loadImage("spray.png");
 generatedImage = createGraphics(750, 450);
}

void draw() { 
  toolGrid.drawGrid();
  colorGrid.drawGrid();
  sizeGrid.drawGrid();
  fontGrid.drawGrid();
  importExportGrid.drawGrid();
  
  if (importedImagesArray != null) {
    for (Image image : importedImagesArray) {
      image.drawFromStart();
    }
  }
  
  // ---- shape grid ( show/hide )---
  if (isShape)
    shapeGrid.drawGrid();
  else{
    fill(pozadina);
    stroke(pozadina); 
    rect(200, 5, 400, 94);
  }
  
  // --- photo grid ( show/hide )----
  if(photoSelected){
     photoGrid.drawGrid();
  }
  else {
    fill(pozadina);
    stroke(pozadina);
    rect(900, 100, 200, 100);
  }
  //-----------------------------------
  
  if( (mousePressed && houseButton.unutar()) || houseSelected){
    houseSelected=true; 
    float scaleX = 750 / house.width;
    float scaleY = 450 / house.height;
    float minScale = min(scaleX, scaleY);

    house.scale(minScale);
    shape(house, 200, 280);
    }
  if( (mousePressed && carButton.unutar()) || carSelected){
    carSelected=true; 
    float scaleX = 750 / car.width;
    float scaleY = 450 / car.height;
    float minScale = min(scaleX, scaleY);
    
    car.scale(minScale);
    shape(car, 300, 200);
  }
  if( (mousePressed && butterflyButton.unutar()) || butterflySelected) {
    butterflySelected=true;
    //print("butterfly \n");
    float scaleX = 750 / butterfly.width;
    float scaleY = 450 / butterfly.height;
    float minScale = min(scaleX, scaleY);

    butterfly.scale(minScale);
    float butterflyWidth = butterfly.width * minScale;
    float butterflyHeight = butterfly.height * minScale;
    butterfly.width = butterflyWidth;
    butterfly.height = butterflyHeight;
    //float scale = cp5.getController("importedImageScale").getValue();
         
    //butterfly.width = butterflyWidth * scale;
    //butterfly.height = butterflyHeight * scale;
    //print("prije " + butterfly.width + " h " + butterfly.height);
    if (resizedImageInsideCanvas(mouseX, mouseY, butterfly.width, butterfly.height)){
      shape(butterfly, mouseX, mouseY);
    }
    //print("NAKON\n"); 
    shape(butterfly, 20, 10);
    
    
  }
  if( (mousePressed && catButton.unutar()) || catSelected){
    catSelected=true; 
    float scaleX = 750 / cat.width;
    float scaleY = 450 / cat.height;
    float minScale = min(scaleX, scaleY);

    cat.scale(minScale);
    shape(cat, 0, 100);
  }
  
  firstChosenColorButton.nacrtajGumb();
  secondChosenColorButton.nacrtajGumb();
  
  colorRect = color(cp5.getController("red").getValue(), cp5.getController("green").getValue(), cp5.getController("blue").getValue());
  fill(colorRect);
  rect(800, 610, 100, 100);
    
  useSelectedTool();
  useSelectedShape();
  
  if (generatedImage != null) {
    image(generatedImage, 105, 100);
  }
}

void mouseClicked() {
  if (toolGrid.returnPressedButton() != null) {
    if (pressedToolButton != null) {
      pressedToolButton.unSelectedVisualUpdate();
    }
    pressedToolButton = toolGrid.returnPressedButton();
    if( pressedToolButton != null){
      pressedToolButton.selectedVisualUpdate();
       print("image name: " + pressedToolButton.imageName + "\n");
    }
  }
  
  if (sizeGrid.returnPressedButton() != null) {
    if (pressedSizeButton != null) {
      pressedSizeButton.unSelectedVisualUpdate();
    }
    pressedSizeButton = sizeGrid.returnPressedButton();
    if ( pressedSizeButton != null) {
      pressedSizeButton.selectedVisualUpdate();
      print("image name: " + pressedSizeButton.imageName + "\n");
    }
  }

  if (fontGrid.returnPressedButton() != null) {
    if (pressedFontButton != null) {
      pressedFontButton.unSelectedVisualUpdate();
    }
    pressedFontButton = fontGrid.returnPressedButton();
    if ( pressedFontButton != null) {
      pressedFontButton.selectedVisualUpdate();
      print("image name: " + pressedFontButton.imageName + "\n");
    }
  }
  
  if (mouseY > 610 && mouseY < 710 && mouseX > 800 && mouseX < 900) {
    colorSelection.rectColor = colorRect;
  }
  if (shapeGrid.returnPressedButton() != null) {
    if (pressedShapeButton != null) {
      pressedShapeButton.unSelectedVisualUpdate();
    }
    pressedShapeButton = shapeGrid.returnPressedButton();
    if( pressedShapeButton != null){
      pressedShapeButton.selectedVisualUpdate();
       print("image name: " + pressedShapeButton.imageName + "\n");
    }
  }
  
  Gumb chosenColorButton = colorGrid.returnPressedButton();
  if( chosenColorButton != null){
    colorSelection.rectColor = chosenColorButton.rectColor;
    print("position: " + chosenColorButton.x + " " + chosenColorButton.y + "\n");
  }
  
  if (firstChosenColorButton.unutar()) {
    colorSelection.unSelectedVisualUpdate();
    colorSelection = firstChosenColorButton;
    colorSelection.selectedVisualUpdate();
  } else if (secondChosenColorButton.unutar()) {
    colorSelection.unSelectedVisualUpdate();
    colorSelection = secondChosenColorButton;
    colorSelection.selectedVisualUpdate();
  }

  if (exportButton.unutar()) {
    exportSelected = true;
    selectOutput("Select a file to process:", "fileSelected");
  }
  if (importButton.unutar()) {
    importSelected = true;
    selectInput("Select a file to process:", "fileSelected");    
  }

  if(importedImagePositionSelected){
    float scale = cp5.getController("importedImageScale").getValue();
    resizedImportedImage.resize(int(resizedImportedImage.width * scale), int(resizedImportedImage.height * scale));
    
    if (resizedImageInsideCanvas(mouseX, mouseY, resizedImportedImage.width, resizedImportedImage.height)) {
      image(resizedImportedImage, mouseX, mouseY);
      Image img = new Image(resizedImportedImage, mouseX, mouseY);
      importedImagePositionSelected = false;
      importedImagesArray.add(img);
    }
  }
}

void useSelectedTool() {
  String velicina, font;
  if (pressedToolButton == null) return;
  String tool = pressedToolButton.name;
  if (pressedSizeButton!=null) {
    velicina = pressedSizeButton.name;
  }
  else velicina = "small";
  if (pressedFontButton!=null) {
    font = pressedFontButton.name;
  }    
  else font="Arial";
  isShape = false;
  photoSelected = false;
  switch (tool) {
    case "gradientPen":
      pencil.gradientPen(3, firstChosenColorButton.rectColor, secondChosenColorButton.rectColor, area);
      break;
    case "magicPen":
      pencil.magicPen(3, area);
      break;
    case "pen":
      pencil.pen(firstChosenColorButton.rectColor, 3, area);
      break;
    case "eraser":
      pencil.eraser(secondChosenColorButton.rectColor, 3, area);
    case "can":
      can.colorCan(firstChosenColorButton.rectColor, area);
      break;
    case "photo":
      photoSelected=true;
      break;
    case "shapes":
      isShape = true;
      break;
    case "text":
      textBlob.tBlob(firstChosenColorButton.rectColor, velicina, font, area);
      break;
    case "spray":
      drawSprayCircle( mouseX, mouseY, 20, 20);
      break;
    default:
      break;
  }
}

void useSelectedShape(){
  
  if (pressedShapeButton == null) return;
  String Shape = pressedShapeButton.name;
  if (pressedToolButton == null) return;
  String tool = pressedToolButton.name;
  if(isShape && tool == "shapes")
  {
      oblici.drawShape(firstChosenColorButton.rectColor,Shape);
  }
}

void keyPressed() {
  if ((key == 's' || key == 'S' )) {
    importSelected = true;
    selectInput("Select a file to process:", "fileSelected");
  }
}

boolean insideCanvas() { //105, 100, 750, 450
  if ( mouseX >= area.left && mouseX <= area.right
    && mouseY >= area.up && mouseY <= area.down) {
    return true;
  }
  return false;
}

boolean resizedImageInsideCanvas(float x, float y, float imageWidth, float imageHeight) {
  if (x >= area.left && x + imageWidth <= area.right &&
      y >= area.up && y + imageHeight <= area.down) {
    return true;
  }
  return false;
}

void setupScaleSlider() {
  cp5.addSlider("importedImageScale")
    .setPosition(890, 70)
    .setWidth(120)
    .setHeight(20)
    .setRange(0.1, 1)
    .setValue(1)
    .setCaptionLabel("scale")
    .setColorBackground(black); 
}
