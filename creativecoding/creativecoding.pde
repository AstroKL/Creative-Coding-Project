Table matchData;

String[] opponents = {"J", "K", "R", "A", "V", "D", "JK"};

int[] wins = new int[opponents.length];
int[] losses = new int[opponents.length];

void setup() {

  size(900, 600);

  matchData = loadTable("Table_Tennis_Win_Loss.csv", "header");

  countResults();

  textAlign(CENTER);
}

void countResults() {

  for (TableRow row : matchData.rows()) {

    String opponent = row.getString("Opponent");
    String result = row.getString("Result");

    for (int i = 0; i < opponents.length; i++) {

      if (opponent.equals(opponents[i])) {

        if (result.equals("Win")) {
          wins[i]++;
        } else {
          losses[i]++;
        }

      }
    }
  }
}

void draw() {

  background(255);

  fill(0);
  textSize(24);
  text("Wins and Losses vs Each Opponent", width/2, 40);

  int chartBottom = 500;
  int chartTop = 100;

  // Find largest value automatically
  int maxValue = 0;

  for (int i = 0; i < opponents.length; i++) {

    if (wins[i] > maxValue) {
      maxValue = wins[i];
    }

    if (losses[i] > maxValue) {
      maxValue = losses[i];
    }
  }

  // Axes
  stroke(0);
  line(80, chartBottom, 850, chartBottom);
  line(80, chartTop, 80, chartBottom);

  // Gridlines and labels
  for (int i = 0; i <= maxValue; i++) {

    float y = map(i, 0, maxValue, chartBottom, chartTop);

    stroke(220);
    line(80, y, 850, y);

    fill(0);
    text(i, 60, y + 5);
  }

  int groupWidth = 90;
  int barWidth = 30;

  for (int i = 0; i < opponents.length; i++) {

    int x = 130 + i * groupWidth;

    // Win bar
    float winHeight =
      map(wins[i],
          0,
          maxValue,
          0,
          chartBottom - chartTop);

    fill(0, 180, 0);

    rect(x,
         chartBottom - winHeight,
         barWidth,
         winHeight);

    // Loss bar
    float lossHeight =
      map(losses[i],
          0,
          maxValue,
          0,
          chartBottom - chartTop);

    fill(220, 50, 50);

    rect(x + 35,
         chartBottom - lossHeight,
         barWidth,
         lossHeight);

    // Labels
    fill(0);

    text(opponents[i],
         x + 17,
         chartBottom + 25);

    text(wins[i],
         x + 15,
         chartBottom - winHeight - 10);

    text(losses[i],
         x + 50,
         chartBottom - lossHeight - 10);
  }

  // Legend
  fill(0, 180, 0);
  rect(650, 60, 20, 20);

  fill(0);
  text("Wins", 710, 75);

  fill(220, 50, 50);
  rect(760, 60, 20, 20);

  fill(0);
  text("Losses", 830, 75);
}