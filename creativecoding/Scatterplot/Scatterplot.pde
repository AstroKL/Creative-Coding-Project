Table matchData;

int[] cumulativeWon;
int[] cumulativeLost;

int maxValue = 0;

void setup() {

  size(1000, 600);

  matchData =
    loadTable("Table_Tennis_Win_Loss.csv",
              "header");

  int totalMatches =
    matchData.getRowCount();

  cumulativeWon =
    new int[totalMatches];

  cumulativeLost =
    new int[totalMatches];

  calculateTotals();

  textAlign(CENTER);
}

void calculateTotals() {

  int runningWon = 0;
  int runningLost = 0;

  int rowIndex = 0;

  for (TableRow row : matchData.rows()) {

    runningWon +=
      row.getInt("KrishScore");

    runningLost +=
      row.getInt("OpponentScore");

    cumulativeWon[rowIndex] =
      runningWon;

    cumulativeLost[rowIndex] =
      runningLost;

    if (runningWon > maxValue) {
      maxValue = runningWon;
    }

    if (runningLost > maxValue) {
      maxValue = runningLost;
    }

    rowIndex++;
  }
}

void draw() {

  background(255);

  fill(0);
  textSize(24);

  text("Cumulative Points Won vs Lost",
       width/2,
       40);

  int left = 80;
  int bottom = 500;
  int top = 100;
  int right = 900;

  stroke(0);

  line(left, bottom,
       right, bottom);

  line(left, top,
       left, bottom);

  // Points Won
  fill(0, 180, 0);

  for (int i = 0;
       i < cumulativeWon.length;
       i++) {

    float x =
      map(i,
          0,
          cumulativeWon.length-1,
          left,
          right);

    float y =
      map(cumulativeWon[i],
          0,
          maxValue,
          bottom,
          top);

    ellipse(x, y, 10, 10);
  }

  // Points Lost
  fill(220, 50, 50);

  for (int i = 0;
       i < cumulativeLost.length;
       i++) {

    float x =
      map(i,
          0,
          cumulativeLost.length-1,
          left,
          right);

    float y =
      map(cumulativeLost[i],
          0,
          maxValue,
          bottom,
          top);

    ellipse(x, y, 10, 10);
  }

  // Legend
  fill(0, 180, 0);
  ellipse(750, 70, 12, 12);

  fill(0);
  text("Points Won", 820, 75);

  fill(220, 50, 50);
  ellipse(750, 100, 12, 12);

  fill(0);
  text("Points Lost", 820, 105);
}