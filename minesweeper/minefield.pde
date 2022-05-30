Minefield theField;

public class Minefield {
  int[][] bombs;
  boolean [][] flagged;
  boolean[][] revealed;
  color col1;
  color col2;
  int size; 
  int bombsNum = 100;
  int flagsNum;

  Minefield(int size) {
    this.size = size;
    flagsNum = bombsNum;
    bombs = new int[size][size];
    flagged=new boolean[size][size];
    revealed=new boolean[size][size];
    for (int x=0; x<size; x++) {
      for (int y=0; y<size; y++) {
        bombs[x][y]=0;
        flagged[x][y]=false;
        revealed[x][y]=false;
        
      }
    }
  }

  void showBombs() {
    for (int x = 0; x< size; x++) {
      for (int y = 0; y< size; y++) {
        if (bombs[x][y]==1) {
          revealed[x][y]=true;
          
        }
      }
    }
  }



    void plantBombs() {
      Random rand = new Random(); 
      int i = 0;
      while (i<bombsNum) {
        int x = rand.nextInt(size);
        int y = rand.nextInt(size);
        if (bombs[x][y]==1)continue;
        bombs[x][y]=1;
        i++;
      }
    }

    void clearBombs() {
      for (int x = 0; x<size; x++) {
        for (int y = 0; y<size; y++) {
          bombs[x][y] = 0;
        }
      }
    }

    boolean outBounds(int x, int y) {
      return x<0||y<0||x>=size||y>=size;
    }


    int countBombs(int x, int y) {
      if (outBounds(x, y))return 0;
      int bombCount=0;
      for (int offsetX=-1; offsetX<=1; offsetX++) {
        for (int offsetY=-1; offsetY<=1; offsetY++) {
          if (outBounds(offsetX+x, offsetY+y))continue;
          bombCount+= bombs[x + offsetX][y+offsetY];
        }
      }
      return bombCount;
    }

    void reveal(int x, int y) {
      if (outBounds(x, y))return;
      if (revealed[x][y])return;
      revealed[x][y]=true;
      if (countBombs(x, y)>0)return;
      reveal(x-1, y+1);//the neighbouring cells are revealed
      reveal(x+1, y-1);
      reveal(x+1, y+1);
      reveal(x-1, y);
      reveal(x+1, y);
      reveal(x, y-1);
      reveal(x, y+1);
    }




    void flagIt(int x, int y) {
      flagged[x][y]=!flagged[x][y];
      return;
    }

    void display(int cellBigness) {
      for (int x = 0; x< size; x++) {
        for (int y = 0; y< size; y++) {
          //println("hey");
          col1 = color(15, 137, 171);
          col2 = color(180, 227, 240);

          strokeWeight(2);
          stroke(15, 59, 74);
          if (revealed[x][y]) {
            fill (col2);
          } else {
            fill (col1);
          }
          if (bombs[x][y]!=0&&revealed[x][y]){
            fill(232, 226, 137);
          }
          square(x*cellBigness, y*cellBigness, cellBigness);
          if (flagged[x][y]) {
            image(snowflake, x*sideSize, y*sideSize);
          }
          int around = countBombs(x, y);
          if (revealed[x][y]&&around>0&&bombs[x][y]!=1) {
            color textCol = color(0);
            if (around == 1) {
              textCol = color(68, 111, 212);
            }
            if (around == 2) {
              textCol = color(111, 173, 115);
            }
            if (around == 3) {
              textCol = color(199, 66, 128);
            }
            if (around == 4) {
              textCol = color(245, 193, 98);
            }
            if (around == 5) {
              textCol = color(129, 80, 153);
            } 
            fill(textCol);
            textAlign(LEFT, TOP);
            textSize(sideSize);
            text(str(around), x*sideSize, y*sideSize);
          }
        }
      }
    }
  }
