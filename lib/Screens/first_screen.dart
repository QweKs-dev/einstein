import 'package:einstein/Additionaly/EmbedScreen.dart';
import 'package:einstein/Screens/start_screen.dart';
import 'package:einstein/core/NeiroController.dart';
import 'package:flutter/material.dart';

class FirstScreen extends EmbedScreen {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
          children: [
            Center(child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: ChoiceOfDifficulty()))
          ],
        )
    );
  }
}
