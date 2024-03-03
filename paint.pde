import controlP5.*; // Koristimo Textfield iz biblioteke controlC5. //<>// //<>// //<>//
import ddf.minim.*; // Koristimo biblioteku Minim za dodavanje zvuka

ControlP5 cp5;
Pencil pencil = new Pencil();
Can can = new Can();
<<<<<<< HEAD
=======
Oblici oblici = new Oblici();
>>>>>>> a64543e1754702883e837488a8fb3da92e6741d5

PGraphics helpScreen;
boolean isTyping = false;
boolean Shapes= false;

String tool;

PFont font;
int numGenImages = 0;
Textfield generatedImageTextfield;
boolean isSaveVisible = false;
int saveTimeStart, saveTimeStop = millis();

color black = color(0,0,0);
color grey = color (190,190,190);
color darkRed = color(140, 59, 59);
color red = color(185, 59, 59);
color orange = color (255,165,0);
color yellow = color(255, 255, 0);
color green = color (0,128,0);
color turquoise = color( 173,234,234);
color marine = color(30, 203, 225);
color purple = color(58, 39, 216);
<<<<<<< HEAD
color colorRect = color(int(random(255)), int(random(255)), int(random(255)));
=======
color white = color (255, 255, 255);
color lightGrey = color(205,201,201);
color brown = color(139,101,8);
color copper = color(133,99,99);
color spicyPink = color(255,28,174);
color gold = color(255,215,0);
color beige = color(255,246,143);
color lime = color(0,255,0);

>>>>>>> a64543e1754702883e837488a8fb3da92e6741d5

Gumb help = new Gumb( 50, 30);
Gumb he = new Gumb( 70, 90);

Gumb firstChosenColorButton = new Gumb(0, 595, purple);
Gumb secondChosenColorButton = new Gumb(0, 645, yellow);
Gumb colorSelection = firstChosenColorButton;
Gumb pressedToolButton;
Gumb pressedShapeButton;

Gumb saveImageButton = new Gumb(850,620, 70, 50, "Spremi sliku");

Grid_ toolGrid = new Grid_(3, 2);
<<<<<<< HEAD
Gumb[] toolButtons= { new Gumb("pen"), new Gumb("magicPen"), new Gumb("can"), help, he };
=======
Gumb[] toolButtons= { new Gumb("pen"), new Gumb("magicPen"), new Gumb("can"), help, he ,new Gumb("shapes", darkRed) };
>>>>>>> a64543e1754702883e837488a8fb3da92e6741d5
Grid_ colorGrid = new Grid_(2, 14); // [2][14]
Gumb[] colorButtons = { new Gumb(30, 30, 30, 30, black), new Gumb(30, 30, 30, 30, grey), new Gumb(30, 30, 30, 30, darkRed), new Gumb(30, 30, 30, 30, red), 
new Gumb(30, 30, 30, 30, orange), new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, green), new Gumb(30, 30, 30, 30, turquoise), 
new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple), new Gumb(30, 30, 30, 30, white), new Gumb(30, 30, 30, 30, lightGrey),
new Gumb(30, 30, 30, 30, brown), new Gumb(30, 30, 30, 30, spicyPink), new Gumb(30, 30, 30, 30, gold), new Gumb(30, 30, 30, 30, beige),
new Gumb(30, 30, 30, 30, lime), new Gumb(30, 30, 30, 30, copper), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple)};

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
  
  colorRect = color(cp5.getController("red").getValue(), cp5.getController("green").getValue(), cp5.getController("blue").getValue());
  fill(colorRect);
  rect(800, 610, 100, 100);
    
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
  
<<<<<<< HEAD
  if (mouseY > 610 && mouseY < 710 && mouseX > 800 && mouseX < 900) {
    colorSelection.rectColor = colorRect;
=======
    if (shapeGrid.returnPressedButton() != null) {
    if (pressedShapeButton != null) {
      pressedShapeButton.unSelectedVisualUpdate();
    }
    pressedShapeButton = shapeGrid.returnPressedButton();
    if( pressedShapeButton != null){
      pressedShapeButton.selectedVisualUpdate();
       print("image name: " + pressedShapeButton.imageName + "\n");
    }
>>>>>>> a64543e1754702883e837488a8fb3da92e6741d5
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
<<<<<<< HEAD
=======
    case "shapes":
      oblici.drawShape(firstChosenColorButton.rectColor,Shape, area);
      break;
>>>>>>> a64543e1754702883e837488a8fb3da92e6741d5
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
