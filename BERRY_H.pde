class Berry {
  int xCoord, yCoord;
  private boolean overlap; //dummy boolean used in generating berry location
  
  Berry() {
    generateBerry();
  }
  
  void generateBerry() {
    overlap=true;
    while (overlap) {
      xCoord = floor(random(0,VSIZE))*GRIDSIZE+MARGIN;
      yCoord = floor(random(0,HSIZE))*GRIDSIZE+MARGIN+BARHEIGHT;
      overlap=false;
      for (int i=0; i<snake.getLength(); i++) {
        //ensures the berry does not overlap any part of the snake
        if ((xCoord==snake.queue[i][0])&&(yCoord==snake.queue[i][1])) {overlap=true; break;}
      }
    }
    //println("NEW BERRY AT: "+xCoord+yCoord);
  }
  
  void show() {
    fill(255,0,0);
    rect(xCoord, yCoord, GRIDSIZE, GRIDSIZE);
  }
  
  void reset() {
    generateBerry();
  }
}