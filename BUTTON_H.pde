class Button {
  private int xCoord, yCoord, wide, tall;
  private String label; //text displayed over the button
  private int R, G, B; //normal colour set
  private int dR, dG, dB; //darker colour set
  private int tR, tG, tB; //true set used in show()
  
  //counter and active used to implement interactivity
  private int counter=0;
  private boolean active = false;
  
  Button(float _xCoord, float _yCoord) {
    xCoord=floor(_xCoord);
    yCoord=floor(_yCoord);
    tall=10;
    wide=20;
    setLabel(""); //default label empty
    setColor(255); //default color white
  }
  
  Button(float _xCoord, float _yCoord, int _wide, int _tall) {
    xCoord=floor(_xCoord);
    yCoord=floor(_yCoord);
    tall=_tall;
    wide=_wide;
    setLabel("");
    setColor(255);
  }
  
  void setColor(int _color) {
    R=_color; G=R; B=R;
    dR=R-30; dG=G-30; dB=B-30;
    tR=R; tG=G; tB=B;
  }
  
  void setColor(int _R, int _G, int _B) {
    R=_R;
    G=_G;
    B=_B;
    dR=R-30; dG=G-30; dB=B-30;
    tR=R; tG=G; tB=B;
  }
  
  void setLabel(String _label) {
    label=_label;
  }
  
  void show() {
    stroke(0);
    fill(tR,tG,tB);
    rect(xCoord, yCoord, wide, tall);
    fill(0);
    textSize(floor(0.05*min(width,height)));
    textAlign(CENTER);
    text(label, xCoord+0.5*wide, yCoord+0.7*tall); //displays label over the button
    textAlign(LEFT);
  }
  
  void hover() {
    //darker colour set is used if mouse is over the button
    if (!(mouseX<xCoord)&&!(mouseX>xCoord+wide)&&!(mouseY<yCoord)&&!(mouseY>yCoord+tall)) {
      tR = dR; tG = dG; tB = dB;
    } else {
      tR = R; tG = G; tB = B;
    }
  }
  
  void click() {
    if (!(mouseX<xCoord)&&!(mouseX>xCoord+wide)&&!(mouseY<yCoord)&&!(mouseY>yCoord+tall)) {
      active=!active;
      counter++;
    }
  }
  
  int getCounter() {
    return counter;
  }
  
  boolean getActive() {
    return active;
  }
  
  void reset() {
    active=false;
    counter=0;
  }
}