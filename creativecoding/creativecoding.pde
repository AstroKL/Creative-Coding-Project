Table matchData;

String[] opponents = {"J", "K", "R", "A", "V", "D", "JK"};

int[] wins = new int[opponents.length];
int[] losses = new int[opponents.length];

void setup() {
  size(900, 600);

  matchData = loadTable("Table_Tennis_Win_Loss.csv", "header");

  countResults();
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

  int chartBottom = 500;
  int chartTop = 100;

  line(80, chartBottom, 850, chartBottom);
  line(80, chartTop, 80, chartBottom);

  int groupWidth = 90;
  int barWidth = 30;

  for (int i = 0; i < opponents.length; i++) {

    int x = 130 + i * groupWidth;

    float winHeight = map(wins[i], 0, 5, 0, 400);

    fill(0, 200, 0);
    rect(x, chartBottom - winHeight, barWidth, winHeight);

    float lossHeight = map(losses[i], 0, 5, 0, 400);

    fill(255, 0, 0);
    rect(x + 35, chartBottom - lossHeight, barWidth, lossHeight);

    fill(0);
    text(opponents[i], x + 17, chartBottom + 20);
  }
}