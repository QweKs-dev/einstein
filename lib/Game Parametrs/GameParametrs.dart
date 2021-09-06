import 'dart:math';

class GameParametrs {
  static final GameParametrs _singleton = GameParametrs._internal();
  factory GameParametrs() {
    return _singleton;
  }

  GameParametrs._internal();

  int choosingDifficult;


  bool plusMode = false;
  bool minusMode = false;
  bool multiplicationMode = false;
  bool divisionMode = false;
}
