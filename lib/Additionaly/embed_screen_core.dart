import 'package:flutter/material.dart';

class EmbedScreenBulder {
  static Widget buildScreen(
      {Widget appBar, Widget body, Widget bottomBar, Widget drawer}) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/image/main_back.jpg"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
          Scaffold(
            appBar: appBar ,
            body: body ?? Container(),
            bottomNavigationBar: bottomBar,
            drawer: drawer,
            backgroundColor: Colors.transparent,
          )
        ],
      ),
    );
  }
}
