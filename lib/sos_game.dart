import 'package:flutter/material.dart';

class SOS extends StatefulWidget {
  const SOS({super.key});

  @override
  State<SOS> createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  List<List<String>> gridValues =
      List.generate(5, (row) => List.generate(5, (col) => ''));
  List<List<int>> check =
      List.generate(5, (row) => List.generate(5, (col) => 0));
  List<List<Color>> Tile_colors = List.generate(
      5,
      (row) => List.generate(
          5, (col) => const Color.fromARGB(255, 184, 195, 213))); // 2D grid
  final List<String> Ops1 = ['S', 'O'];
  bool reset = false;
  int p1 = 0;
  int p2 = 0;
  int count = 0; // Options for selection
  int selectedRow = -1;
  int selectedCol = -1;

  String message = 'Select S or O';
  // Message to display
  void changecolor(List<List<int>> temp) {
    for (var tile in temp) {
      int ro = tile[0];
      int co = tile[1];
      if (count % 2 == 1)
        Tile_colors[ro][co] = Colors.green;
      else
        Tile_colors[ro][co] = Colors.red;
    }
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        for (var tile in temp) {
          int row = tile[0];
          int col = tile[1];
          Tile_colors[row][col] = Colors.yellow;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.red, // background color for Player 1
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Player 1 Score: $p1',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Optional spacing between containers
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.green, // background color for Player 2
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Player 2 Score: $p2',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Display the message
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Primary grid (5x5)
            Expanded(
              flex: 2,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // 5 columns
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                padding: EdgeInsets.all(5),
                itemCount: 25, // Total tiles (5x5 grid)
                itemBuilder: (context, index) {
                  int row = index ~/ 5; // Row index
                  int col = index % 5; // Column index
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // Set the selected row and column
                        selectedRow = row;
                        selectedCol = col;
                        reset = false;
                        if (count <24) {
                          if (!reset) message = 'Select S or O';
                        }
                        else{
                          if(p1>p2)
                          message='Player 1 Wins';
                          else if(p2>p1)
                          message='Player 2 Wins';
                          else
                          message="it is a tie";
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedRow == row && selectedCol == col
                            ? Colors.blueAccent
                            : Tile_colors[row][col], // Highlight selection
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          gridValues[row][col],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Secondary grid for selecting 'S' or 'O'
            // Show only if a tile is selected
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            setState(() {
                              gridValues[selectedRow][selectedCol] = 'S';
                              int r = selectedRow;
                              int c = selectedCol;
                              int f = 0;
                              List<List<int>> temp = [];
                              if (r < 3 && gridValues[r + 1][c] == 'O') {
                                if (gridValues[r + 2][c] == 'S') {
                                  f++;
                                  temp.add([r, c]);
                                  temp.add([r + 1, c]);
                                  temp.add([r + 2, c]);
                                  print(temp);
                                }
                              }
                              if (r > 1 && gridValues[r - 1][c] == 'O') {
                                if (gridValues[r - 2][c] == 'S') {
                                  f++;
                                  temp.add([r, c]);
                                  temp.add([r - 1, c]);
                                  temp.add([r - 2, c]);
                                  print(temp);
                                }
                              }
                              if (c < 3 && gridValues[r][c + 1] == 'O') {
                                if (gridValues[r][c + 2] == 'S') {
                                  f++;
                                  temp.add([r, c]);
                                  temp.add([r, c + 1]);
                                  temp.add([r, c + 2]);
                                  print(temp);
                                }
                              }
                              if (c > 1 && gridValues[r][c - 1] == 'O') {
                                if (gridValues[r][c - 2] == 'S') {
                                  f++;
                                  temp.add([r, c]);
                                  temp.add([r, c - 1]);
                                  temp.add([r, c - 2]);
                                  print(temp);
                                }
                              }
                              if (r < 3 &&
                                  c < 3 &&
                                  gridValues[r + 1][c + 1] == 'O') {
                                if (gridValues[r + 2][c + 2] == 'S') {
                                  f++;
                                  temp.add([r, c]);
                                  temp.add([r + 1, c + 1]);
                                  temp.add([r + 2, c + 2]);
                                  print(temp);
                                }
                              }
                              if (r > 1 &&
                                  c > 1 &&
                                  gridValues[r - 1][c - 1] == 'O') {
                                if (gridValues[r - 2][c - 2] == 'S') {
                                  f++;
                                  temp.add([r, c]);
                                  temp.add([r - 1, c - 1]);
                                  temp.add([r - 2, c - 2]);
                                  print(temp);
                                }
                              }
                              if (r < 3 &&
                                  c > 1 &&
                                  gridValues[r + 1][c - 1] == 'O') {
                                if (gridValues[r + 2][c - 2] == 'S') {
                                  f++;
                                  temp.add([r, c]);
                                  temp.add([r + 1, c - 1]);
                                  temp.add([r + 2, c - 2]);
                                  print(temp);
                                }
                              }
                              if (r > 1 &&
                                  c < 3 &&
                                  gridValues[r - 1][c + 1] == 'O') {
                                if (gridValues[r - 2][c + 2] == 'S') {
                                  f++;
                                  temp.add([r, c]);
                                  temp.add([r - 1, c + 1]);
                                  temp.add([r - 2, c + 2]);
                                  print(temp);
                                }
                              }
                              if (f > 0) {
                                if (count % 2 == 0) {
                                  p1 = p1 + f;
                                } else {
                                  p2 = p2 + f;
                                }
                              }
                              changecolor(temp);
                              // Reset the selection
                              selectedRow = -1;
                              selectedCol = -1;
                              count++;
                            });
                          },
                          child: Container(
                              height: 50,
                              width: 100,
                              child: Center(
                                  child: Text(
                                'S',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            setState(() {
                              gridValues[selectedRow][selectedCol] = 'O';
                              int r = selectedRow;
                              int c = selectedCol;
                              int f = 0;
                              List<List<int>> temp = [];
                              if (r > 0 &&
                                  gridValues[r - 1][c] == 'S' &&
                                  r + 1 <= 4 &&
                                  gridValues[r + 1][c] == 'S') {
                                f++;
                                temp.add([r, c]);
                                temp.add([r - 1, c]);
                                temp.add([r + 1, c]);
                                print(temp);
                              }
                              if (c > 0 &&
                                  gridValues[r][c - 1] == 'S' &&
                                  c + 1 <= 4 &&
                                  gridValues[r][c + 1] == 'S') {
                                f++;
                                temp.add([r, c]);
                                temp.add([r, c - 1]);
                                temp.add([r, c + 1]);
                                print(temp);
                              }
                              if (r > 0 &&
                                  c > 0 &&
                                  gridValues[r - 1][c - 1] == 'S' &&
                                  r + 1 <= 4 &&
                                  c + 1 <= 4 &&
                                  gridValues[r + 1][c + 1] == 'S') {
                                f++;
                                temp.add([r, c]);
                                temp.add([r - 1, c - 1]);
                                temp.add([r + 1, c + 1]);
                                print(temp);
                              }
                              if (r < 4 &&
                                  c > 0 &&
                                  gridValues[r + 1][c - 1] == 'S' &&
                                  r - 1 >= 0 &&
                                  c + 1 <= 4 &&
                                  gridValues[r - 1][c + 1] == 'S') {
                                f++;
                                temp.add([r, c]);
                                temp.add([r + 1, c - 1]);
                                temp.add([r - 1, c + 1]);
                                print(temp);
                              }
                              if (f > 0) {
                                if (count % 2 == 0) {
                                  p1 = p1 + f;
                                } else {
                                  p2 = p2 + f;
                                }
                              }
                              // Reset the selection
                              changecolor(temp);
                              selectedRow = -1;
                              selectedCol = -1;
                              count++;
                            });
                          },
                          child: Container(
                              height: 50,
                              width: 100,
                              child: Center(
                                  child: Text(
                                'O',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ))))
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        for (int i = 0; i < 5; i++) {
                          for (int j = 0; j < 5; j++) {
                            gridValues[i][j] = '';

                            p1 = 0;
                            p2 = 0;
                            count = 0;
                            message = ' ';
                            Tile_colors[i][j] =
                                const Color.fromARGB(255, 184, 195, 213);
                            reset = true;
                            setState(() {});
                          }
                        }
                      },
                      child: Container(
                          height: 50,
                          width: 100,
                          child: Center(
                              child: Text('Reset',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)))))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
