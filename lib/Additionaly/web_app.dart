
import 'package:einstein/Screens/first_screen.dart';
import 'package:einstein/Screens/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class WebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //loadLanguage();
    GetStorage storage = GetStorage();
    var lang=storage.hasData("lang")?storage.read("lang"):null;

    return GetMaterialApp(
      title: 'Einstein',
      defaultTransition: Transition.native,
      debugShowCheckedModeBanner: false,
      home: LoadScreen(),
    );
  }
}