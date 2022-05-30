//Anna Likhanova <al2318@bard.edu>
//CMSC_141 Dec 17
//I did not collaborate on this assignment
//With assistance from the tutors Arnav and Darrion
//and this source: https://medium.com/@ArmstrongCS/making-minesweeper-in-10-minutes-e4c4e810fa06


import java.util.Random;

int sideSize = 25;
public int squareNum = 25;
//boolean firstClick = true;
PImage snowflake;

void setup() {
  settings();
  snowflake = loadImage("snowflake.png");
  snowflake.resize(sideSize, sideSize);
  theField = new Minefield(squareNum);
  //theField.plantBombs();
  //theField.display(squareNum, sideSize);
  background(100);
  //theField = new Minefield(squareNum);
}

public void settings() {
  size(sideSize*squareNum, sideSize*squareNum);
}

boolean firstClick=true;

void mousePressed() {  
  int x=int(mouseX/sideSize);
  int y=int(mouseY/sideSize);
  if (mouseButton==RIGHT) {
    if (theField.revealed[x][y]) return;
    theField.flagIt(x, y);
    theField.flagsNum--;
    if (theField.flagsNum<1) {
      println("You do not have any flags left");
      return;
    }
  } else {
    println("leftclick");
    if (firstClick) {
      firstClick=false;
      theField.clearBombs();
      theField.plantBombs();
    }
    if (theField.flagged[x][y]) return;
    else { 
      theField.reveal(x, y);
      println(str(theField.revealed[x][y]));
      println(str(theField.countBombs(x, y)));
    }

    if (theField.bombs[x][y]!=0) {
      theField.reveal(x, y);
      theField.showBombs();
      println("Dang!");

      //fill(232, 226, 137);
      //square(x*sideSize, y*sideSize, sideSize);
      //exit();
    } //else //{

    // }
  }
}

void keyPressed() {
  if (key == ' ') {
    firstClick = true;
    for (int x=0; x<squareNum; x++) {
      for (int y=0; y<squareNum; y++) {
        theField.bombs[x][y]=0;
        theField.flagged[x][y]=false;
        theField.revealed[x][y]=false;
      }
    }
  }
}

void draw() {
  theField.display(sideSize);
   
}
