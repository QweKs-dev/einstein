import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:einstein/Additionaly/GetRouter.dart';
import 'package:einstein/Additionaly/ScreenAdaptation.dart';
import 'package:einstein/Additionaly/embed_statefull_screen.dart';
import 'package:einstein/Game%20Parametrs/ExpressionGenerator.dart';
import 'package:einstein/Game%20Parametrs/GameParametrs.dart';
import 'package:einstein/Screens/new_pop_up_cupons.dart';
import 'package:einstein/Screens/no_coupons_screen.dart';
import 'package:einstein/Screens/start_screen.dart';
import 'package:einstein/View/number_pad.dart';
import 'package:einstein/core/NeiroApiProcesser.dart';
import 'package:einstein/core/NeiroController.dart';
import 'package:einstein/core/models/coupon.dart';
import 'package:einstein/coupons/coupons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sprintf/sprintf.dart';

import '../main.dart';
import 'await_timer_screen.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends EmbedStatefullScreenState<GameScreen> {
  final couponStorage = GetStorage('CouponStorage');
  final einstainCacha = GetStorage('einstainCacha');
  List<String> couponId = [];
  int couponTransfer = 1;

  Expression expressionEl;
  bool condition = true;
  String expressionText = '';
  TextEditingController textEditingController = TextEditingController();

  bool isStarted = false;
  bool isShow = false;

  int seconds = 10;
  Timer _timer;
  double progress;

  int _tickets = 0;
  int ticketsOnScreen = 0;
  int _countDifficulty;

  sendToUser(ComplexResponse res, NeiroCoupon coupon, {String url}) async {
    if (res.success) {
      couponTransfer++;
      await Get.dialog(PopUpCupons(
        res.success,
        info: coupon,
        url: url,
      ));
      if (couponId.isEmpty)
        couponStorage.write(
            'time', (DateTime.now().add(Duration(hours: 24))).toString());
      couponId.add(coupon.id);
      couponStorage.write('getItCoupon', jsonEncode({'data': couponId}));
      // coupons =
      //     coupons.where((element) => !couponId.contains(element.id)).toList();
      // if (coupons.isEmpty) {
      //   await Future.delayed(Duration(milliseconds: 5000));
      //   GetRouter.off(AwaitTimerScreen());
      // }
    }
    startGame();
  }

  startApiCoupon() async {
    var coupons = await NeiroController().getCoupons();
    if (couponStorage.hasData('getItCoupon'))
      couponId = (jsonDecode(couponStorage.read('getItCoupon'))['data'] as List)
          .cast();
    coupons = coupons..shuffle(Random());
    coupons = coupons.where((element) {
      if (couponTransfer % 5 == 0)
        return element.category == 'суперпризы';
      else
        return element.category != 'суперпризы';
    }).toList();
    coupons.removeWhere((element) => couponId.contains(element.id));
    if (coupons.isEmpty) GetRouter.off(NoCouponsScreen());
    var coupon = (coupons)[0];
    ComplexResponse res;
    fieldDefaultState();
    if (profileChannel.canRun()) {
      if (!profileChannel.profile.hasListeners)
        profileChannel.profile.addListener(() async {
          res = await NeiroApiProcesser()
              .transferCoupon(profileChannel.profile.value.email, coupon.id, 1);
          sendToUser(res, coupon, url: null);
        });
    } else {
      res = await NeiroApiProcesser().shareCoupon(1, coupon.id);
      if (res.success) {
        var link = res.response.data['data']['url'];
        var url = 'https://neirobank.com/?id=' '${link.split('/').last}';
        sendToUser(res, coupon, url: url);
      } else
        Get.snackbar('ERROR', res.data.toString());
    }
    profileChannel.requerProfile();
  }

  checkAnswer() async {
    bool rightAnswer =
        textEditingController.text == expressionEl.result.toString();
    if (rightAnswer) {
      _tickets++;
    } else {
      _tickets = 0;
      _countDifficulty = einstainCacha.read('difficult');
    }
    //_tickets = _countDifficulty;
    if (_tickets < _countDifficulty) {
      fieldDefaultState();
      Get.dialog(Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, size) {
            double width = size.maxHeight / 3.5;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: width),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width / 17),
                    color: Colors.white,
                  ),
                  child: AspectRatio(
                    aspectRatio: 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          rightAnswer
                              ? Icons.check_circle_outline
                              : Icons.cancel_outlined,
                          color: rightAnswer ? Colors.green : Colors.red,
                          size: width * 0.8,
                        ),
                        Flexible(
                          child: AutoSizeText(
                            rightAnswer
                                ? ('ПРАВИЛЬНЫЙ ОТВЕТ\n'
                                    'До получения приза осталось правильных ответов: ${_countDifficulty - _tickets}')
                                : ('НЕПРАВИЛЬНЫЙ ОТВЕТ\n'
                                    'Сконцентрируйся и у тебя все получится.\n'
                                    'До получения приза осталось  правильных ответов: ${_countDifficulty - _tickets}'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: ScreenAdaptation.sp(70),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ));
      await Future.delayed(Duration(milliseconds: 2500));
      if (Get.isDialogOpen) Get.back();
      startGame();
    } else {
      _countDifficulty++;
      einstainCacha.write('difficult', _countDifficulty);
      fieldDefaultState();
      startApiCoupon();
    }
  }

  showNumbers() async {
    await Future.delayed(Duration(milliseconds: 1000));
    for (int i = 0; i < expressionEl.outList.length; i += 2) {
      if (!isStarted) return;
      expressionText += expressionEl.outList[i];
      if (i + 1 < expressionEl.outList.length)
        expressionText += expressionEl.outList[i + 1];
      setState(() {});
      if (expressionEl.outList.length - i > 2)
        await Future.delayed(Duration(milliseconds: 1500));
    }
    if (!isStarted) return;
    isShow = true;
  }

  startGame() {
    fieldDefaultState();
    isStarted = true;
    showNumbers();
  }

  fieldDefaultState() {
    if (einstainCacha.hasData('difficult'))
      _countDifficulty = einstainCacha.read('difficult');
    else {
      einstainCacha.write('difficult', 1);
      _countDifficulty = einstainCacha.read('difficult');
    }
    setState(() {
      isStarted = false;
      isShow = false;
      expressionEl = Expression();
      expressionEl.startMode();
      expressionText = '';
      seconds = 10;
      textEditingController.text = '';
      progress = 0;
    });
  }

  @override
  void initState() {
    //fieldDefaultState();
    startGame();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isShow) return;
      seconds--;
      progress += 0.1;
      if (seconds == 0) {
        progress = 0;
        checkAnswer();
      }
      setState(() {});
    });
  }

  @override
  Widget generateBody(BuildContext context) {
    // TODO: implement generateBody
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // FractionallySizedBox(
          //   widthFactor: 0.6,
          //   child: AutoSizeText(
          //     'Tickets counter: ${box.read('Tickets')}',
          //     style: TextStyle(
          //       fontSize: ScreenAdaptation.sp(100),
          //       fontWeight: FontWeight.bold,
          //       fontFamily: 'Fedra Sans',
          //     ),
          //   ),
          // ),
          Flexible(
            child: FractionallySizedBox(
              widthFactor: 0.2,
              heightFactor: 0.2,
              child: Stack(children: [
                Center(
                  child: AutoSizeText(
                    seconds.toString(),
                    style: TextStyle(
                      fontSize: ScreenAdaptation.sp(80),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Fedra Sans',
                    ),
                  ),
                ),
                Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      backgroundColor: Colors.cyanAccent,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                      value: progress,
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                expressionText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Fedra Sans',
                ),
              ),
              Text(
                '=',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Fedra Sans',
                ),
              ),
              Container(
                //color: Colors.red,
                width: 200,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Введите ответ",
                  ),
                  controller: textEditingController,
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     if (!isStarted)
              //       ElevatedButton(
              //         onPressed: startGame,
              //         child: Text('START'),
              //       )
              //     else
              //       ElevatedButton(
              //         onPressed: fieldDefaultState,
              //         child: Text('STOP'),
              //       )
              //   ],
              // ),
            ],
          ),
          if (!isStarted)
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 1.2,
              ),
            )
          else
            Flexible(
              child: NumberPad(
                textEditingController: textEditingController,
                onPressedForCheck: checkAnswer,
              ),
            ),
          AspectRatio(
            aspectRatio: 60,
          )
        ],
      ),
    );
  }
}
