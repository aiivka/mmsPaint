import java.util.ArrayList;

class Oblici{
  float startX, startY, endX, endY;
  float udalj, srceSize, udaljX, udaljY, R1, R2, pocX, pocY;
  float Radijus, PRadius, centarX, centarY, uX, uY, w, h;
  float X1, X2, X3, Y1, Y2, Y3;
  float RX1, RX2, RX3, RX4, RY1, RY2, RY3, RY4;
  
  
  int mouseHeld = 0;
  String shape;
  
  // svaki u posebnoj listi radi moguce undo implementacije
  
  // svi oblici
  ArrayList<float[]> pravokutnici = new ArrayList<float[]>();
  ArrayList<float[]> krugovi = new ArrayList<float[]>(); 
  ArrayList<float[]> srca = new ArrayList<float[]>();
  ArrayList<float[]> zvijezde = new ArrayList<float[]>();
  ArrayList<float[]> trokuti = new ArrayList<float[]>();
  ArrayList<float[]> rombovi = new ArrayList<float[]>();
  ArrayList<float[]> linije = new ArrayList<float[]>();
  ArrayList<float[]> peterokuti = new ArrayList<float[]>();
  ArrayList<float[]> Zvijezdice = new ArrayList<float[]>();     // visekrake
  ArrayList<float[]> maleZvijezdice = new ArrayList<float[]>(); // cetverokrake
  ArrayList<float[]> obliPravokutnici = new ArrayList<float[]>();
  ArrayList<float[]> streliceL = new ArrayList<float[]>();   // left
  ArrayList<float[]> streliceR = new ArrayList<float[]>();   // rigth
  ArrayList<float[]> streliceU = new ArrayList<float[]>();   // up
  ArrayList<float[]> streliceD = new ArrayList<float[]>();   // down
  
  
  
  Oblici(){
  }
 

  
  void drawShape( color boja, String oblikCrtaj, DrawArea area)
  {    
    shape = oblikCrtaj;
    dodajOblik();
    fill(255);  // koje boje?
    stroke(boja);     strokeWeight(2); 
    
    if (oblikCrtaj == "Rectangle" && !pravokutnici.isEmpty()){
    float[] p = pravokutnici.get(pravokutnici.size() - 1);
    rect(p[0],p[1],p[2],p[3]); // x, y, sirina, visina
    }
    if (oblikCrtaj == "OvalRect" && !obliPravokutnici.isEmpty()){
    float[] o = obliPravokutnici.get(obliPravokutnici.size() - 1);
    rect(o[0],o[1],o[2],o[3], o[4]); // x, y, sirina, visina, zaoblj
    }
    if (oblikCrtaj == "Circle" && !krugovi.isEmpty()){
    float[] k = krugovi.get(krugovi.size() - 1);
    circle(k[0], k[1], k[2]);  // x, y, r
    }
    if (oblikCrtaj == "Heart" && !srca.isEmpty()){
    float[] s = srca.get(srca.size() - 1);
    nacrtajSrce(s[0], s[1], s[2]);  // x, y, d
    }
    if (oblikCrtaj == "Star" && !zvijezde.isEmpty()){
    float[] z = zvijezde.get(zvijezde.size() - 1);
    nacrtajZvijezdu(z[0], z[1], z[2]);  // x, y, c
    }
    if (oblikCrtaj == "Triangle" && !trokuti.isEmpty()){
    float[] t = trokuti.get(trokuti.size() - 1);
    triangle(t[0], t[1], t[2], t[3], t[4], t[5]);  // x1, y1, x2, y2, x3, y3
    }
    if (oblikCrtaj == "Rhombus" && !rombovi.isEmpty()){
    float[] r = rombovi.get(rombovi.size() - 1);
    quad(r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7]);  // x1, y1, x2, y2, x3, y3, x4, y4
    }
    if (oblikCrtaj == "Line" && !linije.isEmpty()){
    float[] l = linije.get(linije.size() - 1);
    line(l[0], l[1], l[2], l[3]); // x1, y1, x2, y2
    }
    if (oblikCrtaj == "Pentagon" && !peterokuti.isEmpty()){
    float[] p = peterokuti.get(peterokuti.size() - 1);
    nacrtajPeterokut(p[0], p[1], p[2]); // x1, y1, r
    }
    if (oblikCrtaj == "MultiStar" && !Zvijezdice.isEmpty()){
    float[] c = Zvijezdice.get(Zvijezdice.size() - 1);
    nacrtajZvijezdicu(c[0], c[1], c[2], c[3]); // x1, y1, r
    }
    if (oblikCrtaj == "SmallStar" && !maleZvijezdice.isEmpty()){
      float[] m = maleZvijezdice.get(maleZvijezdice.size() - 1);
      nacrtajMaluZvijezdu(m[0], m[1], m[2], m[3]); // x, y, r1, r2

    }
    if (oblikCrtaj == "ArrowL" && !streliceL.isEmpty()){
    float[] s = streliceL.get(streliceL.size() - 1);
    nacrtajStrelicuL(s[0], s[1], s[2], s[3]);
    }
    if (oblikCrtaj == "ArrowR" && !streliceR.isEmpty()){
    float[] s = streliceR.get(streliceR.size() - 1);
    nacrtajStrelicuR(s[0], s[1], s[2], s[3]);
    }
    if (oblikCrtaj == "ArrowU" && !streliceU.isEmpty()){
    float[] s = streliceU.get(streliceU.size() - 1);
    nacrtajStrelicuU(s[0], s[1], s[2], s[3]); 
    }
    if (oblikCrtaj == "ArrowD" && !streliceD.isEmpty()){
    float[] s = streliceD.get(streliceD.size() - 1);
    nacrtajStrelicuD(s[0], s[1], s[2], s[3]);
    }
    
    obrubi();
    return;
    
  }

  void dodajOblik() {
    if (startX < area.left || startX > area.right || startY < area.up || startY > area.down) return;
      if( mouseHeld == 2  && shape == "Rectangle"){
        mouseHeld = 0;
        float a[] = {startX, startY, endX, endY};
        pravokutnici.add(a);
  }
        if( mouseHeld == 2  && shape == "Circle"){
        mouseHeld = 0;
        float a[] = {uX, uY, udalj};
        krugovi.add(a);
  }
        if( mouseHeld == 2  && shape == "Heart"){
        mouseHeld = 0;
        float a[] = {startX, startY, srceSize};
        srca.add(a);
  }
       if( mouseHeld == 2  && shape == "Star"){
        mouseHeld = 0;
        float a[] = {centarX, centarY, Radijus};
        zvijezde.add(a);
  }
         if( mouseHeld == 2  && shape == "Triangle"){
        mouseHeld = 0;
        float a[] = {X1, Y1, X2, Y2, X3, Y3};
        trokuti.add(a);
  }
        if( mouseHeld == 2  && shape == "Rhombus"){
        mouseHeld = 0;
        float a[] = { RX1, RY1, RX2, RY2, RX3, RY3, RX4, RY4};
        rombovi.add(a);
  }
        if( mouseHeld == 2  && shape == "Line"){
        mouseHeld = 0;
        float a[] = { startX, startY, endX + startX, endY + startY};
        linije.add(a);
  }
       if( mouseHeld == 2  && shape == "Pentagon"){
        mouseHeld = 0;
        float a[] = { centarX, centarY, PRadius};
        peterokuti.add(a);
  }
       if( mouseHeld == 2  && shape == "MultiStar"){
        mouseHeld = 0;
        float a[] = { startX, startY, endX, endY};
        Zvijezdice.add(a);
  }
       if( mouseHeld == 2  && shape == "SmallStar"){
        mouseHeld = 0;
        float a[] = { centarX, centarY, R1,R2};
        maleZvijezdice.add(a);
  }
        if( mouseHeld == 2  && shape == "OvalRect"){
        mouseHeld = 0;
        float a[] = { startX, startY, endX, endY, 20 };
        obliPravokutnici.add(a);
  }
        if( mouseHeld == 2  && shape == "ArrowL"){
        mouseHeld = 0;
        float a[] = { startX, startY, endX + startX, endY + startY };
        streliceL.add(a);
  }
        if( mouseHeld == 2  && shape == "ArrowR"){
        mouseHeld = 0;
        float a[] = { startX, startY, endX + startX, endY + startY };
        streliceR.add(a);
  }
        if( mouseHeld == 2  && shape == "ArrowU"){
        mouseHeld = 0;
        float a[] = { startX, startY, endX + startX, endY + startY};
        streliceU.add(a);
  }
        if( mouseHeld == 2  && shape == "ArrowD"){
        mouseHeld = 0;
        float a[] = { startX, startY, endX + startX, endY + startY};
        streliceD.add(a);
  }
  return;
 }
   void nacrtajSrce(float a, float b, float c){
    //Lijeva strana srca
    beginShape();
    vertex(a, b + c / 4);
    bezierVertex(a - c / 2, b - c / 2, a - c, b + c / 3, a, b + c);
    endShape();
    
    // Desna strana srca
    beginShape();
    vertex(a, b + c / 4 );
    bezierVertex(a + c / 2, b - c / 2, a + c, b + c / 3, a, b + c);
    endShape();
  }
  
  void nacrtajZvijezdu(float cx, float cy, float R){
      int numPoints = 5; // Broj vrhova zvijezde
      float angle = TWO_PI / numPoints; // Kut između svakog vrha
      
      beginShape();
      for (int i = 0; i < numPoints * 2; i++) {
        float r = (i % 2 == 0) ? R * 0.5 : R; // Odabir vanjskog ili unutarnjeg radijusa
        float x = cx + cos(angle* i - HALF_PI) * r; // X koordinata vrha
        float y = cy + sin(angle * i - HALF_PI) * r; // Y koordinata vrha
        vertex(x, y); // Dodavanje vrha u oblik
        i++;
      }
      endShape(CLOSE);
  }
  
  void nacrtajPeterokut(float cx, float cy, float radius){
      int numPoints = 5; 
      beginShape();
      for (int i = 0; i < numPoints; i++) {
        float angle = TWO_PI / numPoints * i; // Kut između svakog vrha
        float x = cx + cos(angle + 60) * radius; // X koordinata vrha
        float y = cy + sin(angle + 60) * radius; // Y koordinata vrha
        vertex(x, y); // Dodavanje vrha u oblik
      }
      endShape(CLOSE);
  }
  
  void nacrtajZvijezdicu(float x, float y, float  w, float h){
      float cx = x + w / 2;;
      float cy = y + h /2;
      float outerRadius = min( w/2, h/2);
      float innerRadius = outerRadius * 0.4;
    
      beginShape();
      for (int i = 0; i < 10; i++) {
        float angle = TWO_PI / 10 * i - HALF_PI;
        float x1 = cx + cos(angle) * outerRadius;
        float y1 = cy + sin(angle) * outerRadius;
        vertex(x1, y1);
    
        angle += TWO_PI / 20;
        float x2 = cx + cos(angle) * innerRadius;
        float y2 = cy + sin(angle) * innerRadius;
        vertex(x2, y2);
      }
      endShape(CLOSE);
  }
 
  void nacrtajMaluZvijezdu(float Cx, float Cy, float rO, float rI){
      beginShape();
      for (int i = 0; i < 8; i++) {
        float angle = TWO_PI / 8 * i + PI / 8; // Kut između svake točke
        float x = Cx + cos(angle+60) * ((i % 2 == 0) ? rO: rI); // X koordinata vrha
        float y = Cy + sin(angle+60) * ((i % 2 == 0) ? rO : rI); // Y koordinata vrha
        vertex(x, y); // Dodavanje vrha u oblik
      }
      endShape(CLOSE);
  }
  
  void nacrtajStrelicuR(float x, float y, float z, float w){       
      float x1 = x + (z-x)/2; // X koordinata lijevog vrha trokuta
      float y1 = y; // Y koordinata lijevog vrha trokuta
      float x2 = x + (z-x)/2; // X koordinata desnog vrha trokuta
      float y2 = w; // Y koordinata desnog vrha trokuta
      float x3 = z; // X koordinata vrha trokuta
      float y3 = y + (w-y)/2; // Y koordinata vrha trokuta 
     
      triangle(x1, y1, x2, y2, x3, y3);
      rect(x, y + (w-y)/4, (z-x)/2, (w-y)/2);
  }
  
  void nacrtajStrelicuL(float x, float y, float z, float w){
      float x1 = x + (z-x)/2; // X koordinata lijevog vrha trokuta
      float y1 = w; // Y koordinata lijevog vrha trokuta
      float x2 = x + (z-x)/2; // X koordinata desnog vrha trokuta
      float y2 = y; // Y koordinata desnog vrha trokuta
      float x3 = x; // X koordinata vrha trokuta
      float y3 = y + (w-y)/2; // Y koordinata vrha trokuta 
     
      triangle(x1, y1, x2, y2, x3, y3);
      rect(x + (z-x)/2, y + (w-y)/4, (z-x)/2, (w-y)/2);
  }
  void nacrtajStrelicuU(float x, float y, float z, float w){
      float x1 = x; // X koordinata lijevog vrha trokuta
      float y1 = y + (w-y)/2; // Y koordinata lijevog vrha trokuta
      float x2 = z; // X koordinata desnog vrha trokuta
      float y2 = y + (w-y)/2; // Y koordinata desnog vrha trokuta
      float x3 = x + (z-x)/2; // X koordinata vrha trokuta
      float y3 = y; // Y koordinata vrha trokuta 
     
      triangle(x1, y1, x2, y2, x3, y3);
      rect(x+ (z-x)/4, y+ (w-y)/2, (z-x)/2, (w-y)/2);
  }    
  void nacrtajStrelicuD(float x, float y, float z, float w){
      float x1 = x; // X koordinata lijevog vrha trokuta
      float y1 = y + (w-y)/2; // Y koordinata lijevog vrha trokuta
      float x2 = z; // X koordinata desnog vrha trokuta
      float y2 = y + (w-y)/2; // Y koordinata desnog vrha trokuta
      float x3 = x + (z-x)/2; // X koordinata vrha trokuta
      float y3 = w; // Y koordinata vrha trokuta 
     
      triangle(x1, y1, x2, y2, x3, y3);
      rect(x+ (z-x)/4, y, (z-x)/2, (w-y)/2);
  }
  
    


  void mousePressed() {
  startX = mouseX;
  startY = mouseY;
  mouseHeld = 1;
}

void mouseReleased() {
  
  // ----------------- za pravokutnik -------------------------------------
  endX = mouseX - startX;
  endY = mouseY - startY;

 //------------------- za krug --------------------------------------------
  udalj = dist(startX, startY, mouseX, mouseY);
  uX = startX + endX/2;
  uY = startY + endY/2;
 //-------------------- za srce --------------------------------------------
  udaljX = startX + dist(startX, startY, mouseX, mouseY);
  udaljY = startY + dist(startX, startY, mouseX, mouseY);
  srceSize = dist(startX, startY, udaljX, udaljY);
  
 //-------------------- za zvijezdu -----------------------------------------
 centarX = startX + endX/2;
 centarY = startY + endY/2; 
 Radijus = startX < mouseX ? dist(startX, startY, udaljX, udaljY) - 30 : 0;
 
 //-------------------- za trokut -------------------------------------------
 X1 = startX ;
 Y1 = mouseY;
 X2 = startX + (mouseX - startX)/2;
 Y2 = startY;
 X3 = mouseX;
 Y3 = mouseY;
 
 //-------------------- za romb ---------------------------------------------
 RX1 = startX;
 RY1 = startY + (mouseY - startY)/2;
 RX2 = startX + (mouseX - startX)/2;
 RY2 = mouseY;
 RX3 = mouseX;
 RY3 = startY + (mouseY - startY)/2;
 RX4 = startX + (mouseX - startX)/2;
 RY4 = startY;
 
 //------------------- za peterokut ----------------------------------------
 PRadius = dist(centarX, centarY, startX , startY);
 
 //------------------- za Zvijezdicu --------------------------------
  pocX = startX + endX/2;
  pocY = startY + endY/2;
  R1 = endX/6;
  R2 = endX/2;
 //------------------------------------------------------
    
  mouseHeld = 2;
}

}
void mousePressed() {
  oblici.mousePressed();
}

void mouseReleased() {
  oblici.mouseReleased();
}

void obrubi(){
  
  //------ siva pozadina iscrtavanje nakon svakog oblika ------
  color pozadina = color(203,203,204);
  stroke(pozadina);
  fill(pozadina);
  rect(0, 0, 1050, area.up-2); // gornji
  rect(0, 0, area.left-2, 750 -100); // lijevo
  rect(0, 750 - 198, 1050, 750 -198); // donji
  rect(1050 -193 , 0, 1050 - 200, 750); // desno
  
  //------------------------- redraw ---------------------------
    shapeGrid.drawGrid();
    toolGrid.drawGrid();
    colorGrid.drawGrid();
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
 //----------------------------------------------------------------------------
}
