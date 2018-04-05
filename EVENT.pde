void mousePressed() {
  //switch case used to navigate frames, and button counters 
  //are used to check whether a button has been clicked
  //a new frame will be loaded into with default settings via reset functions
  switch (frame) {
    //************************************//
    case 'a':
    a_howToPlay.click();
    a_highScores.click();
    a_play.click();
    if (a_howToPlay.getCounter()!=0) { 
      frame='c';
      c_back.reset();
    } else if (a_play.getCounter()!=0) {
      frame='b';
      snake.reset(); 
      berry.reset();
      b_back.reset();
      victorName="";
    } else if (a_highScores.getCounter()!=0) {
      frame='d';
      d_back.reset();
    }
    break;
    //************************************//
    case 'b':
    b_back.click();
    if (b_back.getCounter()!=0) {
      frame='a';
      a_howToPlay.reset();
      a_highScores.reset();
      a_play.reset();
    }
    if (!snake.checkHealth()&&!(finalScore>lowestScore)) {
      b_replay.click();
      snake.reset(); 
      berry.reset();
      b_back.reset();
      victorName="";
    }
    break;
    //************************************//
    case 'c':
    c_back.click();
    if (c_back.getCounter()!=0) {
      frame='a';
      a_howToPlay.reset();
      a_highScores.reset();
      a_play.reset();
    }
    break;
    //************************************//
    case 'd':
    d_back.click();
    if (d_back.getCounter()!=0) {
      frame='a';
      a_howToPlay.reset();
      a_highScores.reset();
      a_play.reset();
    }
    break;
  }
}

void checkHover() {
  switch (frame) {
    case 'a':
    a_howToPlay.hover();
    a_highScores.hover();
    a_play.hover();
    break;
    //************************************//
    case 'b':
    b_back.hover();
    if (!snake.checkHealth()&&!(finalScore>lowestScore)) {
      b_replay.hover(); //button unique to game over screen
    }
    break;
    //************************************//
    case 'c':
    c_back.hover();
    break;
    //************************************//
    case 'd':
    d_back.hover();
    break;
  }
}

void keyPressed() {
  switch (frame) {
    case 'a':
    break;
    //************************************//
    case 'b':
    //game not over: checks for pause, unpause, and direction change commands
    if (snake.checkHealth()) { 
      if (snake.checkSleep()) {
        snake.wake();
      } else if ((key=='p')||(key=='P')) {
        snake.sleep();
      }
      if (key==CODED) {
        snake.directionChange();
      }
    } else {
      //game over: generating new high score entry
      if (finalScore>lowestScore) {
        if ((key==BACKSPACE)&&(victorName.length()!=0)) {
          victorName=victorName.substring(0,victorName.length()-1); //backspace as usual in name entry - stored in victorName variable
        } else if (key==ENTER) {
          //adds new row to the existing high scores table upon enter keypress
          int temporary;
          newRow = hallOfFame.addRow(); 
          if (victorName!="") {
            newRow.setString("NAME", victorName.toUpperCase());
          } else {
            newRow.setString("NAME", "PLAYER");
          }
          newRow.setInt("SCORE", finalScore);
          
          //calculates position of new hs entry within the leaderboard
          for (int i=0; i<hallOfFame.getRowCount()-1; i++) {
            if (finalScore>hallOfFame.getRow(i).getInt("SCORE")) {newRank=i; /*println("found rank at:"+i);*/ break;}
          }
          
          //increments the ranks of all scores lower than the new one
          for (int i=newRank; i<hallOfFame.getRowCount()-1; i++) {
            temporary = hallOfFame.getRow(i).getInt("RANK");
            hallOfFame.getRow(i).setInt("RANK", (temporary+1));
          }
          newRow.setInt("RANK",newRank+1);
         
          //sorts hallOfFame by rank, and removes all rows beyond the 6th row ("limited system memory")
          hallOfFame.sort("RANK");
          for (int i=7; i<hallOfFame.getRowCount(); i++) {
            hallOfFame.removeRow(i);
          }
            
          //saves and backs up the new high score table
          saveTable(hallOfFame, "HIGHSCORES.csv");
          saveTable(hallOfFame, "BACKUP.csv");
  
          //finds new lowest score for future high scores
          lowestScore=hallOfFame.getRow(0).getInt("SCORE");
          for (int i=1; i<min(hallOfFame.getRowCount(),6); i++) {
            if (lowestScore>=hallOfFame.getRow(i).getInt("SCORE")) { lowestScore=hallOfFame.getRow(i).getInt("SCORE");}
          }
          
          //resets victorName and navigates directly to highscores page
          victorName="";
          frame='d';
          d_back.reset();
          
        } else if ((key!=CODED)&&(victorName.length()<8)) {
          enterName(key); //allows player to type in their name
        } 
      }
    }
    break;
    //************************************//
    case 'c':
    break;
    //************************************//
    case 'd':
    break;
  }
}

//======================================================================================

void enterName(int letter) {
  //allows entry of english characters into victorName variable
  switch (letter) {
    case 'a':
    victorName+='a';
    break;
    case 'A':
    victorName+='A';
    break;
    case 'b':
    victorName+='b';
    break;
    case 'B':
    victorName+='B';
    break;
    case 'c':
    victorName+='c';
    break;
    case 'C':
    victorName+='C';
    break;
    case 'd':
    victorName+='d';
    break;
    case 'D':
    victorName+='D';
    break;
    case 'e':
    victorName+='e';
    break;
    case 'E':
    victorName+='E';
    break;
    case 'f':
    victorName+='f';
    break;
    case 'F':
    victorName+='F';
    break;
    case 'g':
    victorName+='g';
    break;
    case 'G':
    victorName+='G';
    break;
    case 'h':
    victorName+='h';
    break;
    case 'H':
    victorName+='H';
    break;
    case 'i':
    victorName+='i';
    break;
    case 'I':
    victorName+='I';
    break;
    case 'j':
    victorName+='j';
    break;
    case 'J':
    victorName+='J';
    break;
    case 'k':
    victorName+='k';
    break;
    case 'K':
    victorName+='K';
    break;
    case 'l':
    victorName+='l';
    break;
    case 'L':
    victorName+='L';
    break;
    case 'm':
    victorName+='m';
    break;
    case 'M':
    victorName+='M';
    break;
    case 'n':
    victorName+='n';
    break;
    case 'N':
    victorName+='N';
    break;
    case 'o':
    victorName+='o';
    break;
    case 'O':
    victorName+='O';
    break;
    case 'p':
    victorName+='p';
    break;
    case 'P':
    victorName+='P';
    break;
    case 'q':
    victorName+='q';
    break;
    case 'Q':
    victorName+='Q';
    break;
    case 'r':
    victorName+='r';
    break;
    case 'R':
    victorName+='R';
    break;
    case 's':
    victorName+='s';
    break;
    case 'S':
    victorName+='S';
    break;
    case 't':
    victorName+='t';
    break;
    case 'T':
    victorName+='T';
    break;
    case 'u':
    victorName+='u';
    break;
    case 'U':
    victorName+='U';
    break;
    case 'v':
    victorName+='v';
    break;
    case 'V':
    victorName+='V';
    break;
    case 'w':
    victorName+='w';
    break;
    case 'W':
    victorName+='W';
    break;
    case 'x':
    victorName+='x';
    break;
    case 'X':
    victorName+='X';
    break;
    case 'y':
    victorName+='y';
    break;
    case 'Y':
    victorName+='Y';
    break;
    case 'z':
    victorName+='z';
    break;
    case 'Z':
    victorName+='Z';
    break;
  }
}