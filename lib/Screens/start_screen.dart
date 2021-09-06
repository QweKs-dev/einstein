import 'package:auto_size_text/auto_size_text.dart';
import 'package:einstein/Additionaly/EmbedScreen.dart';
import 'package:einstein/Additionaly/GetRouter.dart';
import 'package:einstein/Additionaly/ScreenAdaptation.dart';
import 'package:einstein/Additionaly/smart_padding.dart';
import 'package:einstein/Game%20Parametrs/GameParametrs.dart';
import 'package:einstein/core/NeiroController.dart';
import 'package:flutter/material.dart';

import 'game_screen.dart';

class ChoiceOfDifficulty extends EmbedScreen {

  NeiroController controller = NeiroController();

  @override
  Widget generateBody(BuildContext ctx) {
    ScreenAdaptation.setup(1920, 1080);
    return SmartPadding(
      widthFactor: 0.5,
      heightFactor: 0.8,
      child: Align(
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: 5,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                //primary: Color.fromRGBO(0, 255, 57, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: AutoSizeText(
                'Начать игру',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenAdaptation.sp(70),
                ),
              ),
              onPressed: () {
                GameParametrs().choosingDifficult = 0;
                GameParametrs().plusMode = true;
                GameParametrs().minusMode = false;
                GameParametrs().multiplicationMode = false;
                GameParametrs().divisionMode = false;
                GetRouter.off(GameScreen());

              }),
          // child: Table(
          //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //   children: [
          //     TableRow(
          //       children: [
          //         CouponButton(onPressed: (){
          //           GameParametrs().choosingDifficult = 0;
          //           GameParametrs().plusMode = true;
          //           GameParametrs().minusMode = false;
          //           GameParametrs().multiplicationMode = false;
          //           GameParametrs().divisionMode = false;
          //           GetRouter.to(GameScreen());
          //         },
          //           image: 'assets/images/tesla.jpg',
          //           difficultText: 'Сложность: лёгкая',
          //           text: 'Получите купон на машину',),
          //         CouponButton(onPressed: (){
          //           GameParametrs().choosingDifficult = 1;
          //           GameParametrs().plusMode = true;
          //           GameParametrs().minusMode = true;
          //           GameParametrs().multiplicationMode = false;
          //           GameParametrs().divisionMode = false;
          //           GetRouter.to(GameScreen());
          //         },
          //           image: 'assets/images/tesla.jpg',
          //           difficultText: 'Сложность: средняя',
          //           text: 'Получите купон на машину',),
          //       ],
          //     ),
          //     TableRow(
          //       children: [
          //         CouponButton(onPressed: (){
          //           GameParametrs().choosingDifficult = 2;
          //           GameParametrs().plusMode = true;
          //           GameParametrs().minusMode = true;
          //           GameParametrs().multiplicationMode = true;
          //           GameParametrs().divisionMode = true;
          //           GetRouter.to(GameScreen());
          //         },
          //           image: 'assets/images/tesla.jpg',
          //           difficultText: 'Сложность: высокая',
          //           text: 'Получите купон на машину',),
          //         CouponButton(onPressed: (){
          //           GameParametrs().choosingDifficult = 3;
          //           GameParametrs().plusMode = true;
          //           GameParametrs().minusMode = true;
          //           GameParametrs().multiplicationMode = true;
          //           GameParametrs().divisionMode = true;
          //           GetRouter.to(GameScreen());
          //         },
          //           image: 'assets/images/tesla.jpg',
          //           difficultText: 'Сложность: Эйнштейн',
          //           text: 'Получите купон на машину',),
          //       ],
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
