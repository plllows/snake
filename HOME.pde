void HOME() {
  //title of game, buttons to navigate to instructions, high scores, and the game itself
  background(255);
  fill(20,120,20);
  textSize(floor(0.05*min(width,height)));
  text("welcome to",0.15*width,0.1*height);
  textSize(floor(0.034*min(width,height)));
  text("made by JING",0.70*width,0.97*height);
  textSize(floor(0.09*min(width,height)));
  text("SNAKE GAME :D",0.17*width,0.22*height);
  a_howToPlay.show();
  a_highScores.show();
  a_play.show();
}

void HOWTOPLAY() {
  //basic instructions for playing the game
  background(255);
  fill(20,120,20);
  textSize(floor(0.09*min(width,height)));
  text("How to play?",0.22*width,0.15*height);
  textSize(floor(0.04*min(width,height)));
  text("Use the arrow keys to direct the hungry\nsnake to the apples!",0.1*width,0.3*height); 
  text("However, the snake shouldn't go into the\nwater or bite himself (ouch)!",0.1*width,0.45*height); 
  text("Press 'P' to pause the game at any time,\nand use the buttons to exit to the menu!",0.1*width,0.6*height);
  text("Your score will be displayed at the top\nright of the window!",0.1*width,0.75*height);
  
  c_back.show();
}

void HIGHSCORES() {
  //list the top 5 high scores in hallOfFame table
  background(255);
  fill(20,120,20);
  textSize(floor(0.084*min(width,height)));
  text("LEADERBOARD!",0.2*width,0.15*height);
  textSize(floor(0.05*min(width,height)));
  text("RANK",0.13*width,0.28*height);
  text("NAME",0.4*width,0.28*height);
  text("SCORE",0.7*width,0.28*height);
  
  for (int i=0; i<min(hallOfFame.getRowCount(),5); i++) {
    TableRow row =hallOfFame.getRow(i);
    text(row.getString("RANK"),0.17*width,(0.4+i*0.1)*height);
    textAlign(CENTER);
    text(row.getString("NAME"),0.47*width,(0.4+i*0.1)*height);
    textAlign(LEFT);
    text(row.getString("SCORE"),0.7*width,(0.4+i*0.1)*height);
  }
  
  d_back.show();
}