import 'package:auto_size_text/auto_size_text.dart';
import 'package:einstein/Additionaly/EmbedScreen.dart';
import 'package:einstein/Additionaly/GetRouter.dart';
import 'package:einstein/Additionaly/ScreenAdaptation.dart';
import 'package:einstein/Screens/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get_storage/get_storage.dart';

class AwaitTimerScreen extends EmbedScreen {
  final couponStorage = GetStorage('CouponStorage');
  final einstainCacha = GetStorage('einstainCacha');
  DateTime nowTime = (DateTime.now());
  Duration outputTime;

  init() async {
    DateTime startTimerTime = DateTime.parse(couponStorage.read('time'));
    outputTime = startTimerTime.difference(nowTime);
  }

  @override
  Widget generateBody(BuildContext context) {
    print('TEST');
    print(outputTime.toString());
    print(nowTime.toString());

    init();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, size) {
          double width = size.maxHeight / 3;
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
                        Icons.watch_later_outlined,
                        color: Colors.orangeAccent,
                        size: width * 0.8,
                      ),
                  CountdownTimer(
                        endTime: nowTime.add(outputTime).millisecondsSinceEpoch,
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Все купоны получены,'
                          '\n новые купоны будут доступны по истечению таймера',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                           // couponStorage.remove('time');
                           // couponStorage.remove('getItCoupon');
                           // einstainCacha.remove('difficult');
                          GetRouter.off(LoadScreen());
                        },
                        child: Icon(
                          Icons.update_outlined,
                          size: width * 0.2,
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
    );
    // return Center(
    //     child: Column(
    //       children: [
    //         Text('Все купоны получены,'
    //             '\n новые купоны будут доступны по истечению таймера'),
    //         CountdownTimer(
    //           endTime: nowTime.add(outputTime).millisecondsSinceEpoch,
    //           textStyle: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold,
    //             color: Colors.white,
    //           ),
    //         ),
    //
    //   ],
    // ));
  }
}
