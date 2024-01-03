import 'dart:math';

import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late int turn;

  List<String> displayItems = ['', '', '', '', '', '', '', '', ''];

  late int pc;

  @override
  void initState() {
    super.initState();
    turn = 0;
  }

  void clear() {
    setState(() {
      displayItems = ['', '', '', '', '', '', '', '', ''];
      turn = 0;
      pc = Random().nextInt(2);
    });
    if (pc == 1) {
      // If computer starts, make the first move
      computerMove();
    }
  }

  void computerMove() {
    int computerIndex = -1;

    // Simple logic: Computer randomly chooses an empty cell
    while (computerIndex == -1 || displayItems[computerIndex] != '') {
      computerIndex = Random().nextInt(9);
    }

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        displayItems[computerIndex] = "◯"; // Computer's move
        turn++;
      });

      checkWinner();
    });
  }

  void update(int index) {
    setState(() {
      if (displayItems[index] == '') {
        setState(() {
          displayItems[index] = "✕"; // Player's move
          turn++;
        });

        if (checkWinner()) {
          return;
        }

        if (turn < 9) {
          computerMove();
        } else {
          _showDrawDialog();
        }
      }
    });
  }

  bool checkWinner() {
    // Checking rows
    if (displayItems[0] == displayItems[1] &&
        displayItems[0] == displayItems[2] &&
        displayItems[0] != '') {
      _showWinDialog(displayItems[0]);
      return true;
    }
    if (displayItems[3] == displayItems[4] &&
        displayItems[3] == displayItems[5] &&
        displayItems[3] != '') {
      _showWinDialog(displayItems[3]);
      return true;
    }
    if (displayItems[6] == displayItems[7] &&
        displayItems[6] == displayItems[8] &&
        displayItems[6] != '') {
      _showWinDialog(displayItems[6]);
      return true;
    }

    // Checking Column
    if (displayItems[0] == displayItems[3] &&
        displayItems[0] == displayItems[6] &&
        displayItems[0] != '') {
      _showWinDialog(displayItems[0]);
      return true;
    }
    if (displayItems[1] == displayItems[4] &&
        displayItems[1] == displayItems[7] &&
        displayItems[1] != '') {
      _showWinDialog(displayItems[1]);
      return true;
    }
    if (displayItems[2] == displayItems[5] &&
        displayItems[2] == displayItems[8] &&
        displayItems[2] != '') {
      _showWinDialog(displayItems[2]);
      return true;
    }

    // Checking Diagonal
    if (displayItems[0] == displayItems[4] &&
        displayItems[0] == displayItems[8] &&
        displayItems[0] != '') {
      _showWinDialog(displayItems[0]);
      return true;
    }
    if (displayItems[2] == displayItems[4] &&
        displayItems[2] == displayItems[6] &&
        displayItems[2] != '') {
      _showWinDialog(displayItems[2]);
      return true;
    } else if (turn == 9) {
      _showDrawDialog();
      return true;
    }

    return false;
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  clear();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" $winner \" is Winner!!!"),
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  clear();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tic-Tac-Toe",
                style: TextStyle(fontSize: 40),
              )
            ],
          ),
          const SizedBox(
            height: 80, // Adjust the height as needed
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      update(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(
                          displayItems[index],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 35),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 0, // Adjust the height as needed
          ),
          ElevatedButton(
              onPressed: () {
                clear();
              },
              child: const Text("Reset"))
        ],
      ),
    );
  }
}
