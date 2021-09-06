import 'package:einstein/Additionaly/GetRouter.dart';
import 'package:einstein/Game%20Parametrs/ExpressionGenerator.dart';
import 'package:einstein/Game%20Parametrs/GameParametrs.dart';
import 'package:einstein/Screens/game_screen.dart';
import 'package:flutter/material.dart';

class ChoosingMathOperators extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(child: Text('+'), onPressed: () {
              GameParametrs().plusMode = true;
              GameParametrs().minusMode = false;
              GameParametrs().multiplicationMode = false;
              GameParametrs().divisionMode = false;
              GetRouter.to(GameScreen());

            }),
            ElevatedButton(child: Text('-'), onPressed: () {}),
            ElevatedButton(child: Text('*'), onPressed: () {}),
            ElevatedButton(child: Text('/'), onPressed: () {}),
            ElevatedButton(child: Text('MIXED'), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
