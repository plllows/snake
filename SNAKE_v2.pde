//SNAKE V2
//*****DISPLAY VARIABLES*******************//
//these variables are used to control the speed of the snake
int counter;
int increment;

//tracks number of squares on grid vertically and horizontally
int HSIZE;
int VSIZE;

/*default settings:
gridsize 20
barheight 60
margin 10
width & height 500*/

int GRIDSIZE; //length and width of a square in the grid
int BARHEIGHT; //height of the UI bar in the game frame
int MARGIN; //margin between window edge and game grid

//our main characters!
Snake snake;
Berry berry;

//controls navigation within the program - home menu, high score, howtoplay, and the game itself
char frame = 'a';
/*
a==HOME()
b==GAME()
c==HOWTOPLAY()
d==HIGHSCORE()
*/

//*****buttons*****************************//
//frame a
Button a_howToPlay;
Button a_play;
Button a_highScores;
//frame b
Button b_back;
Button b_replay;
//frame c
Button c_back;
//frame d
Button d_back;

//*****HIGH SCORES VARIABLES****************//
Table hallOfFame; //table stores the high scores
TableRow newRow; //dummy variables used for adding a new entry
int newRank;
String victorName =""; //string to store player name when new highscore created

//determine whether a new highscore is created - lowest score is the 5th highest score in highscores
int lowestScore;
int finalScore;

//===============================================================================

void setup() {
  //*****SET UP GAME*****//
  size(800,800); //default 500 500
  frameRate(40);
  counter=0;
  increment=4; 
  
  GRIDSIZE = floor(0.04*min(width,height));
  BARHEIGHT = floor(0.12*min(width,height)); 
  MARGIN = floor(0.02*min(width,height));
  
  //grids are measured in 20s
  VSIZE=(width-MARGIN-(width%GRIDSIZE))/GRIDSIZE; //#squares in grid row
  HSIZE=(height-2*MARGIN-BARHEIGHT-(height%GRIDSIZE))/GRIDSIZE; //#squares in grid column
  
  //berry cannot overlap the snake, so snake must be created first
  snake = new Snake(); 
  berry = new Berry();
  
  //initialises positions, colours, and labels for all buttons
  initialise_buttons();
  
  //*****SET UP HIGH SCORES*****//
  hallOfFame = loadTable("HIGHSCORES.csv", "header");
  saveTable(hallOfFame, "BACKUP.csv"); //backing up the file
  hallOfFame.sort("RANK");
  
  //find the 5th highest score in high scores as benchmark for new high scores
  lowestScore=hallOfFame.getRow(0).getInt("SCORE");
  for (int i=1; i<min(hallOfFame.getRowCount(),6); i++) {
    if (lowestScore>=hallOfFame.getRow(i).getInt("SCORE")) { lowestScore=hallOfFame.getRow(i).getInt("SCORE");}
  }
  println(lowestScore);
}

void draw() {
  //controls the update of the snake in draw frame
  counter+=increment;
  if (counter==200) {
    counter=20;
  }
  //checks hover for buttons depending on the frame
  checkHover();
  //loads different frames depending on frame variable value
  switch (frame) {
    case 'a':
    HOME();
    break;
    case 'b':
    GAME();
    break;
    case 'c':
    HOWTOPLAY();
    break;
    case 'd':
    HIGHSCORES();
    break;
  }
}

void initialise_buttons() {
  //frame a buttons
  a_play = new Button(0.25*width,0.4*height,floor(0.48*width),floor(0.1*height));
  a_play.setLabel("PLAY THE GAME!");
  a_play.setColor(220,220,80);
  a_howToPlay = new Button(0.25*width,0.55*height,floor(0.48*width),floor(0.1*height));
  a_howToPlay.setLabel("HOW TO PLAY");
  a_howToPlay.setColor(220,220,80);
  a_highScores = new Button(0.25*width,0.7*height,floor(0.48*width),floor(0.1*height));
  a_highScores.setLabel("HIGH SCORES");
  a_highScores.setColor(220,220,80);
  
  //frame b buttons
  b_back = new Button(0.05*width,0.03*height,floor(0.07*width),floor(0.07*height));
  b_back.setLabel("<");
  b_back.setColor(220,220,80);
  b_replay = new Button(0.29*width,0.68*height,floor(0.4*width),floor(0.1*height));
  b_replay.setLabel("REPLAY");
  b_replay.setColor(220,220,80);
  
  //frame c buttons
  c_back = new Button(0.05*width,0.05*height,floor(0.07*width),floor(0.07*height));
  c_back.setLabel("<");
  c_back.setColor(220,220,80);
  
  //frame d buttons
  d_back = new Button(0.05*width,0.05*height,floor(0.07*width),floor(0.07*height));
  d_back.setLabel("<");
  d_back.setColor(220,220,80);
}