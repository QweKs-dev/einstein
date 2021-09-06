import 'dart:convert';
import 'dart:math';

import 'package:einstein/Additionaly/EmbedScreen.dart';
import 'package:einstein/Additionaly/GetRouter.dart';
import 'package:einstein/Screens/await_timer_screen.dart';
import 'package:einstein/Screens/first_screen.dart';
import 'package:einstein/Screens/no_coupons_screen.dart';
import 'package:einstein/Screens/start_screen.dart';
import 'package:einstein/core/NeiroController.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoadScreen extends EmbedScreen {
  final couponStorage = GetStorage('CouponStorage');
  List<String> couponId = [];
  var time;

  init() async {
    await NeiroController().onStart();
    NeiroController().LoadCouponScreen();
    await Future.delayed(Duration(milliseconds: 3000));
    //couponStorage.erase();
    if (couponStorage.hasData('time')) {
      time = DateTime.parse(couponStorage.read('time'));
      if (DateTime.now().isAfter(time)) {
        couponStorage.remove('time');
        couponStorage.remove('getItCoupon');
      }
    }

    var coupons = NeiroController().coupons..shuffle(Random());
    if (coupons.isEmpty) {
      ///Переход на окно (в игре нет купонов)
      GetRouter.off(NoCouponsScreen());
      print('Переход на окно (в игре нет купонов)');
    } else {
      if (couponStorage.hasData('getItCoupon'))
        couponId = (jsonDecode(couponStorage.read('getItCoupon'))['data'] as List).cast();
      coupons = coupons.where((element) => !couponId.contains(element.id)).toList();
      if (coupons.isEmpty) {
        ///Переход на окно (заходите позже)
        print('Переход на окно (заходите позже)');
        GetRouter.off(AwaitTimerScreen());
      } else {
        GetRouter.off(ChoiceOfDifficulty());
      }
    }
  }

  @override
  Widget generateBody(BuildContext context) {
    init();
    return Container();
  }
}
