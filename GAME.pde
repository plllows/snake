void GAME() {
  //main game screen with grid for the game. Bar located at the top to display
  //button to return to main menu, and a counter for the score.
  background(204,239,255); //blue background for the water(?)
  //displays the main grid for the game
  showGrid();
  //displays player's current score at top right of window
  showScore();
  //tells the player how to pause
  showHint();
  
  snake.show();
  berry.show();
  
  //update snake position if not dead and not asleep, at frequency controlled by counter
  if (snake.checkHealth()&&!snake.checkSleep()&&(counter%20==0)) {
    snake.update();
  } else if (snake.checkSleep()) {
    pauseScreen(); //if snake is asleep
  } else if (!snake.checkHealth()){
    deathScreen(); //if snake is dead
  }
  
  //button to return to main menu
  b_back.show();
}

void deathScreen() {
  //calculates player score by extra length gained
  finalScore = snake.getLength()-snake.originalLength;
  
  //displays grey rectangle as textbox
  fill(100,200); 
  rect(50+MARGIN,50+MARGIN+BARHEIGHT,VSIZE*GRIDSIZE-100,HSIZE*GRIDSIZE-100,20);
  fill(255);
  
  if (finalScore>lowestScore) {
    //if new high score has been set
    textSize(floor(0.08*min(width,height)));
    text("OUCH!",0.36*width,0.37*height);
    textSize(floor(0.06*min(width,height)));
    text(finalScore,0.75*width,0.47*height);
    textSize(floor(0.04*min(width,height)));
    text("YOUR FINAL SCORE WAS:",0.2*width,0.46*height);
    text("Congratulations!",0.33*width,0.54*height);
    text("You created a new high score!",0.2*width,0.61*height);
    text("Please enter your name!",0.29*width,0.68*height);
    fill(255);
    rect(0.22*width,0.72*height,0.56*width,0.1*height);
    fill(0);
    textSize(floor(0.07*min(width,height)));
    text(victorName.toUpperCase(),0.25*width,0.80*height);
} else {
    //if new high score has not been set
    textSize(floor(0.08*min(width,height)));
    text("OUCH!",0.36*width,0.39*height);
    textSize(floor(0.06*min(width,height)));
    text(finalScore,0.75*width,0.495*height);
    textSize(floor(0.04*min(width,height)));
    text("YOUR FINAL SCORE WAS:",0.2*width,0.49*height);
    text("Better luck next time!",0.27*width,0.6*height);
    b_replay.show();
  }
}

void pauseScreen() {
  fill(100,200); //grey textbox
  rect(50+MARGIN,50+MARGIN+BARHEIGHT,VSIZE*GRIDSIZE-100,HSIZE*GRIDSIZE-100,20);
  fill(255);
  textSize(floor(0.09*min(width,height)));
  text("PAUSED",0.33*width,0.5*height);
  textSize(floor(0.05*min(width,height)));
  text("press any key to unpause",0.2*width,0.65*height);
}

void showGrid() {
  fill(240,180,160);
  for (int i=0; i<HSIZE; i++) {
    for (int j=0; j<VSIZE; j++) {
      rect(j*GRIDSIZE+MARGIN,i*GRIDSIZE+MARGIN+BARHEIGHT,GRIDSIZE,GRIDSIZE);
    }
  }
}

void showScore() {
  fill(0);
  textSize(floor(0.05*min(width,height))); 
  text("Score:",0.68*width, 0.08*height);
  text(snake.getLength()-snake.originalLength,0.88*width, 0.083*height);
}

void showHint() {
  textSize(floor(0.04*min(width,height)));
  text("Hint: press P to pause!",0.2*width,0.078*height);
}