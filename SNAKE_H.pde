class Snake {
  //used to update position of the snake in every frame
  //directionQueue is used as a secondary command input buffer
  //this ensures players chaining two moves in rapid succession will
  //not have their input fail to register, allowing a smoother UX
  private char direction = 'u';
  private char directionQueue = 'u';
  
  private boolean isAlive = true;
  private boolean isHibernating = false;
  
  final int originalLength = 5; //the initial length of the snake
  private int snakeLength = originalLength; //currentLength
  
  //records x and y location of snake body segments on the grid
  int[][] queue = new int[5000][2];
  
  //temporary variables to store the snake's next position
  private int pX, pY;
  
  //prevent double loading direction
  private boolean updateQueue =false;
  
  Snake() {
    for (int i=0; i<snakeLength; i++) { //default x and y coordinates of the snake's body
      queue[i][0] = (HSIZE/2)*GRIDSIZE+MARGIN;
      queue[i][1] = MARGIN+BARHEIGHT+((VSIZE/2)+i)*GRIDSIZE;
    }
  }
  
  void update() {
   //calculates next position using direction, pX and pY
    switch(direction) {
      case 'u':
      pX=queue[0][0];
      pY=queue[0][1]-GRIDSIZE;
      break;
      case 'd':
      pX=queue[0][0];
      pY=queue[0][1]+GRIDSIZE;
      break;
      case 'l':
      pX=queue[0][0]-GRIDSIZE;
      pY=queue[0][1];
      break;
      case 'r':
      pX=queue[0][0]+GRIDSIZE;
      pY=queue[0][1];
      break;
    }
    //check for outOfBounds - DEATH CONDITION
    if ((pX>=VSIZE*GRIDSIZE+MARGIN)||(pX<MARGIN)||(pY>=HSIZE*GRIDSIZE+BARHEIGHT+MARGIN)||(pY<MARGIN+BARHEIGHT)) {    
      isAlive = false;
    }
    
    //check for berry
    //if berry is found, the tail of the snake is not deleted
    if ((queue[0][0]==berry.xCoord)&&(queue[0][1]==berry.yCoord)) {
      queue[snakeLength][0] = queue[snakeLength-1][0];
      queue[snakeLength][1] = queue[snakeLength-1][1];
      snakeLength++;
      berry.generateBerry();
    }
    //updating snake's body location and check for cannibalism - DEATH CONDITION
    for (int i=snakeLength-1; i>=1; i--) {
      queue[i][0] = queue[i-1][0];
      queue[i][1] = queue[i-1][1];
      if ((pX==queue[i][0])&&(pY==queue[i][1])) {isAlive=false; break;}
    }
    queue[0][0] = pX; queue[0][1] = pY;
    //frees up updateQueue for changing direction
    updateQueue=false;
    direction=directionQueue; //next direction loaded in updateQueue is fed into direction
  }
  
  void show() {
    fill(60,60,90);
    for (int i=0; i<snakeLength; i++) {
      rect(queue[i][0], queue[i][1], GRIDSIZE, GRIDSIZE);
    }
  }
  
  boolean checkSleep() {
    return isHibernating;
  }
  
  void sleep() {
    isHibernating = true;
  }
  
  void wake() {
    isHibernating = false;
  }
  
  boolean checkHealth() {
    return isAlive;
  }
  
  int getLength() {
    return snakeLength;
  }
  
  void directionChange() {
    if (!updateQueue) {
      //if updateQueue is free, direction itself will be changed, and directionQueue updated to match direction
      switch (keyCode) {
        case UP: 
        if (direction!='d') {
          direction='u';
          directionQueue=direction;
          updateQueue=true;
        }
        break;
        case DOWN:
        if (direction!='u') {
          direction='d';
          directionQueue=direction;
          updateQueue=true;
        }
        break;
        case LEFT:
        if (direction!='r') {
          direction='l';
          directionQueue=direction;
          updateQueue=true;
        }
        break;
        case RIGHT:
        if (direction!='l') {
          direction='r';
          directionQueue=direction;
          updateQueue=true;
        }
        break;
      }
    } else {
      //if direction has already been set, any future moves 
      //will be temporarily stored in directionQueue
      switch (keyCode) {
        case UP: 
        if (direction!='d') {
          directionQueue='u'; 
        }
        break;
        case DOWN:
        if (direction!='u') {
          directionQueue='d'; 
        }
        break;
        case LEFT:
        if (direction!='r') {
          directionQueue='l';
        }
        break;
        case RIGHT:
        if (direction!='l') {
          directionQueue='r';
        }
        break;
      }
    }
  }
  
  void reset() {
    direction = 'u';
    directionQueue = 'u';
    snakeLength = originalLength;
    isAlive = true;
    
    //resets snake to its default length and position on the grid
    for (int i=0; i<snakeLength; i++) {
      queue[i][0] = (HSIZE/2)*GRIDSIZE+MARGIN;
      queue[i][1] = MARGIN+BARHEIGHT+((VSIZE/2)+i)*GRIDSIZE;
    }
    updateQueue =false;
  }
}