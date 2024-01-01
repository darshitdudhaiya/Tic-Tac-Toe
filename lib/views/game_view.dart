import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/icon_button_widget.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late int turn;

  List<String> displayItems = ['', '', '', '', '', '', '', '', ''];

  @override
  void initState() {
    super.initState();
    turn = 0;
  }

  void clear() {
    setState(() {
      displayItems = ['', '', '', '', '', '', '', '', ''];
    });
  }

  void update(int index) {
    setState(() {
      if (turn % 2 == 0 && displayItems[index] == '') {
        displayItems[index] = "✕";
        checkWinner();
        turn++;
      } else if (turn % 2 != 0 && displayItems[index] == '') {
        displayItems[index] = "◯";
        checkWinner();
        turn++;
      }
      checkWinner();
    });
  }

  void checkWinner() {
    // Checking rows
    if (displayItems[0] == displayItems[1] &&
        displayItems[0] == displayItems[2] &&
        displayItems[0] != '') {
      _showWinDialog(displayItems[0]);
    }
    if (displayItems[3] == displayItems[4] &&
        displayItems[3] == displayItems[5] &&
        displayItems[3] != '') {
      _showWinDialog(displayItems[3]);
    }
    if (displayItems[6] == displayItems[7] &&
        displayItems[6] == displayItems[8] &&
        displayItems[6] != '') {
      _showWinDialog(displayItems[6]);
    }

    // Checking Column
    if (displayItems[0] == displayItems[3] &&
        displayItems[0] == displayItems[6] &&
        displayItems[0] != '') {
      _showWinDialog(displayItems[0]);
    }
    if (displayItems[1] == displayItems[4] &&
        displayItems[1] == displayItems[7] &&
        displayItems[1] != '') {
      _showWinDialog(displayItems[1]);
    }
    if (displayItems[2] == displayItems[5] &&
        displayItems[2] == displayItems[8] &&
        displayItems[2] != '') {
      _showWinDialog(displayItems[2]);
    }

    // Checking Diagonal
    if (displayItems[0] == displayItems[4] &&
        displayItems[0] == displayItems[8] &&
        displayItems[0] != '') {
      _showWinDialog(displayItems[0]);
    }
    if (displayItems[2] == displayItems[4] &&
        displayItems[2] == displayItems[6] &&
        displayItems[2] != '') {
      _showWinDialog(displayItems[2]);
    } else if (turn == 9) {
      _showDrawDialog();
    }
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
