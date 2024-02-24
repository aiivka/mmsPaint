import controlP5.*; // Koristimo Textfield iz biblioteke controlC5. //<>//
import ddf.minim.*; // Koristimo biblioteku Minim za dodavanje zvuka

ControlP5 cp5;

Gumb help = new Gumb( 50, 30);
Gumb he = new Gumb( 70, 90);

Grid toolGrid = new Grid(3, 2);
Gumb[] toolButtons= { new Gumb("Button1"), new Gumb("Button2"), new Gumb("Button3"), help, he };
Grid colorGrid = new Grid(2, 2); // [2][14]
Gumb[] colorButtons = { new Gumb(30, 30, 30, 30, "red"), new Gumb(30, 30, 30, 30, "blue"), new Gumb(30, 30, 30, 30, "green")};
 
void setup() {
    size(1050, 750);
    rect(105, 100, 750, 450); // white space for drawing
    help.dodajSliku("candy.png");
    toolGrid.addButtons(toolButtons, 0, 0, 50, 50);
    colorGrid.addButtons(colorButtons, 0, 605, 30, 30);
}


void draw() {
  toolGrid.drawGrid();
  colorGrid.drawGrid();
}


void mouseClicked() {
  Gumb pressedToolButton = toolGrid.returnPressedButton();
  if( pressedToolButton != null){
     print("image name: " + pressedToolButton.imageName + "\n");
  }
  Gumb chosenColorButton = colorGrid.returnPressedButton();
  if( chosenColorButton != null){
     print("position: " + chosenColorButton.x + " " + chosenColorButton.y + "\n");
  }
}


void keyPressed() {
  // h - help  
  // s - save
}
