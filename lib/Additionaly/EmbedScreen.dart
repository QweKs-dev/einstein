import 'package:einstein/Additionaly/GetRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


import 'embed_screen_core.dart';

class EmbedScreen extends StatelessWidget {
  Widget generateBody(BuildContext context) => null;

  Widget generateAppBar(BuildContext context) => null;

  Widget generateBottomBar(BuildContext context) => null;

  Widget generateNavBar(BuildContext context) => null;

  Widget _generateAdaptiveBody(BuildContext context) {
    if (GetPlatform.isAndroid || GetPlatform.isIOS)
      return generateBody(context);
    else
      return LayoutBuilder(builder: (context, constrains) {
        return generateBody(context);
      });
  }

  Future<bool> onWillPop() async {
    await GetRouter.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isAndroid)
      return WillPopScope(
          child: EmbedScreenBulder.buildScreen(
            body: _generateAdaptiveBody(context),
            drawer: generateNavBar(context),
            appBar: generateAppBar(context),
            bottomBar: generateBottomBar(context),
          ),
          onWillPop: onWillPop);
    else
      return EmbedScreenBulder.buildScreen(
        body: _generateAdaptiveBody(context),
        drawer: generateNavBar(context),
        appBar: generateAppBar(context),
        bottomBar: generateBottomBar(context),
      );
  }
}
