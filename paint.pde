import controlP5.*; // Koristimo Textfield iz biblioteke controlC5. //<>// //<>// //<>//
import ddf.minim.*; // Koristimo biblioteku Minim za dodavanje zvuka

ControlP5 cp5;
Pencil pencil = new Pencil();
Can can = new Can();
Oblici oblici = new Oblici();

PGraphics helpScreen;
boolean isTyping = false;
boolean Shapes= false;

String tool;

PFont font;
int numGenImages = 0;
Textfield generatedImageTextfield;
boolean isSaveVisible = false;
int saveTimeStart, saveTimeStop = millis();

color yellow = color(255, 255, 153);
color white = color (255, 255, 255);
color red = color(185, 59, 59);
color marine = color(30, 203, 225);
color purple = color(58, 39, 216);

color darkRed = color(140, 59, 59);


Gumb help = new Gumb( 50, 30);
Gumb he = new Gumb( 70, 90);

Gumb firstChosenColorButton = new Gumb(0, 595, purple);
Gumb secondChosenColorButton = new Gumb(0, 645, yellow);
Gumb colorSelection = firstChosenColorButton;
Gumb pressedToolButton;
Gumb pressedShapeButton;

Gumb saveImageButton = new Gumb(850,620, 70, 50, "Spremi sliku");

Grid_ toolGrid = new Grid_(3, 2);
Gumb[] toolButtons= { new Gumb("pen"), new Gumb("magicPen"), new Gumb("can"), help, he ,new Gumb("shapes", darkRed) };
Grid_ colorGrid = new Grid_(2, 14); // [2][14]
Gumb[] colorButtons = { new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, red), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple), 
new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, red), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple), 
new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, red), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple),
new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, red), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple),
new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, red), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple)};

//--------------
Grid_ shapeGrid = new Grid_(5, 3);
Gumb[] shapeButtons = { new Gumb("Line", darkRed), new Gumb("Circle", darkRed),new Gumb("Rectangle", darkRed), new Gumb("Star", darkRed),
                        new Gumb("Heart", darkRed), new Gumb("Triangle", darkRed), new Gumb("Rhombus", darkRed), new Gumb("Pentagon",darkRed),
                        new Gumb("MultiStar", darkRed), new Gumb("SmallStar", darkRed),  new Gumb("OvalRect", darkRed), new Gumb("ArrowL", darkRed), 
                        new Gumb("ArrowR", darkRed), new Gumb("ArrowU", darkRed), new Gumb("ArrowD", darkRed),
                      };


class DrawArea {
  int sizeX = 750, sizeY = 450;
  int left = 105, right = 105 + sizeX, up = 100, down = 100 + sizeY;
}

DrawArea area = new DrawArea();
 
void setup() {
    size(1050, 750);
    rect(area.left, area.up, area.sizeX, area.sizeY); // white space for drawing
    help.dodajSliku("candy.png");
    
    toolGrid.addButtons(toolButtons, 0, 0, 50, 50);
    colorGrid.addButtons(colorButtons, 50, 605, 30, 30);
    shapeGrid.addButtons(shapeButtons, 870, 100, 50, 50);
    
    cp5 = new ControlP5(this);
    font = loadFont("Hiragino15.vlw");
    
    setupSaveImageTextfield();
    saveTimeStop = millis();
    colorSelection.selectedVisualUpdate();
}

void draw() {
  toolGrid.drawGrid();
  colorGrid.drawGrid();
  shapeGrid.drawGrid();

  
  firstChosenColorButton.nacrtajGumb();
  secondChosenColorButton.nacrtajGumb();
  
  if (isSaveVisible ){
    Text nameGenImage = new Text(600, 600, "Unesite ime generirane slike");
    nameGenImage.ispisiText();
    if (saveImageButton.isVisible) {
      saveImageButton.nacrtajGumb();
    }
      
    cp5.get(Textfield.class,"generate").hide();
  }
  
  useSelectedTool();
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

  
  if (saveImageButton.unutar()){
    print("saved\n");
    PImage generatedImage = get(105, 100, 750, 450);
    generatedImage.save("screen" + numGenImages + ".png"); // should write user input 
    generatedImageTextfield.setVisible(false);
    isTyping = false;
    isSaveVisible = false;
    saveImageButton.updateVisibility();
  }
}

void useSelectedTool() {
  if (pressedToolButton == null) return;
  String tool = pressedToolButton.name;

  if (pressedShapeButton == null) return;
  String Shape = pressedShapeButton.name;
  
  
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
    case "shapes":
      oblici.drawShape(firstChosenColorButton.rectColor,Shape, area);
      break;
    default:
      break;
  }
}


void keyPressed() {
  if ((key == 's' || key == 'S' )) { // && !isTyping) {
    //isTyping = true;
    isSaveVisible = true;
    generatedImageTextfield.setVisible(true);
    //generatedImageTextfield.hide();
    //cp5.get(Textfield.class,"generate").hide();
    //saveImageButton.isVisible = true;
  }
  // h - help  
  // s - save
}


void setupSaveImageTextfield(){
  generatedImageTextfield = cp5.addTextfield("generate")
    .setPosition(550, 620)
    .setSize(250, 70)
    .setVisible(false)
    .setColor(color(255,255,204))
    .setColorActive(color(255,255,204)) 
    .setColorForeground(color(255))
    .setColorBackground(color(0))
    .setFont(font)
    .setText("screen");
    
  // hide caption label
  generatedImageTextfield.getCaptionLabel().setText("");
}
