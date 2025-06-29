import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: const TicTacToe(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, '');
  bool xTurn = true;
  String winner = '';

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      xTurn = true;
      winner = '';
    });
  }

  void checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var pattern in winPatterns) {
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];
      if (a != '' && a == b && b == c) {
        setState(() {
          winner = '$a wins 👍';
        });
        return;
      }
    }

    if (!board.contains('')) {
      setState(() {
        winner = "It's a draw! Play again";
      });
    }
  }

  void handleTap(int index) {
    if (board[index] != '' || winner != '') return;

    setState(() {
      board[index] = xTurn ? 'X' : 'O';
      xTurn = !xTurn;
    });

    checkWinner();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double gridWidth = screenWidth * 0.9;
    double cellBorder = 8.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tick Tac Toe!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: gridWidth,
              height: gridWidth,
              child: Table(
                border: TableBorder.symmetric(
                  inside: BorderSide(color: Colors.black, width: 2),
                  outside: BorderSide(color: Colors.black, width: 4),
                ),
                children: List.generate(3, (i) {
                  return TableRow(
                    children: List.generate(3, (j) {
                      int index = i * 3 + j;
                      return GestureDetector(
                        onTap: () => handleTap(index),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              board[index],
                              style: const TextStyle(
                                fontSize: 60,
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              winner,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: resetGame,
              child: const Text('New game'),
            ),
          ],
        ),
      ),
    );
  }
}
