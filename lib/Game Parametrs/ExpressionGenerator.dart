import 'dart:math';

import 'package:einstein/Game%20Parametrs/GameParametrs.dart';
import 'package:flutter/material.dart';

class Expression {
  double result = 0;
  String outExpression = '';
  List<String> outList = [];

  List<String> operators = ['+', '-', '*', '/'];
  List<double> numbers;
  List<String> symbols;

  int _generateSymbol(GameParametrs gameParametrs) {
    int id = Random().nextInt(4);
    if (id == 0 && !gameParametrs.plusMode) {
      id = -1;
    } else if (id == 1 && !gameParametrs.minusMode) {
      id = -1;
    } else if (id == 2 && !gameParametrs.multiplicationMode) {
      id = -1;
    } else if (id == 3 && !gameParametrs.divisionMode) {
      id = -1;
    }
    if (id == -1) return _generateSymbol(gameParametrs);
    return id;
  }

  void startMode() {
    GameParametrs gameParametrs = GameParametrs();
    numbers = List.generate(5, (index) => (Random().nextInt(9)+1).toDouble());
    symbols =
        List.generate(4, (index) => operators[_generateSymbol(gameParametrs)]);
    var numbersDup = [...numbers];
    var symbolsDup = [...symbols];
    while (numbersDup.length > 1) {
      int idMult = symbolsDup.indexOf('*');
      int idDiv = symbolsDup.indexOf('/');
      int symbolId = idMult;
      if (idDiv >= 0 && idDiv < idMult) symbolId = idDiv;
      if (symbolId == -1) symbolId = 0;

      double resProm;

      if (symbolsDup[symbolId] == '*')
        resProm = numbersDup[symbolId] * numbersDup[symbolId + 1];
      if (symbolsDup[symbolId] == '/')
        resProm = numbersDup[symbolId] / numbersDup[symbolId + 1];
      if (symbolsDup[symbolId] == '+')
        resProm = numbersDup[symbolId] + numbersDup[symbolId + 1];
      if (symbolsDup[symbolId] == '-')
        resProm = numbersDup[symbolId] - numbersDup[symbolId + 1];

      numbersDup[symbolId] = resProm;
      symbolsDup.removeAt(symbolId);
      numbersDup.removeAt(symbolId+1);
    }
    result = numbersDup[0];
    if(result < 0 || result.toInt() != result) startMode() ; else{
      String resStr = numbers[0].toString();
      outExpression = numbers[0].toString();
      outList.add(numbers[0].toString());
      for(int i = 0; i < symbols.length; i++){
        resStr += symbols[i];
        outList.add(symbols[i]);
        outExpression += symbols[i];
        resStr += numbers[i+1].toString();
        outExpression += numbers[i+1].toString();
        outList.add(numbers[i+1].toString());
      }
    }


  }
}
