import 'package:einstein/Additionaly/EmbedScreen.dart';
import 'package:einstein/Additionaly/smart_padding.dart';
import 'package:flutter/material.dart';

class NumberPad extends EmbedScreen {
  TextEditingController textEditingController;

  NumberPad(
      {@required this.onPressedForCheck, this.textEditingController});

  GestureTapCallback onPressedForCheck;

  buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      textEditingController?.text = '';
    } else if (buttonText != 'C') {
      textEditingController?.text += buttonText;
    }
  }

  Widget buildCheckButton() {
    return AspectRatio(
      aspectRatio: 1,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.9,
        child: ElevatedButton(
          child: Icon(Icons.check),
          onPressed: onPressedForCheck,
        ),
      ),
    );
  }

  Widget buildNumberPad(String buttonText) {
    return AspectRatio(
      aspectRatio: 1,
      child: SmartPadding(
        widthFactor: 0.9,
        heightFactor: 0.9,
        child: ElevatedButton(
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 3/4,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                buildNumberPad('1'),
                buildNumberPad('2'),
                buildNumberPad('3'),
              ],
            ),
            TableRow(
              children: [
                buildNumberPad('4'),
                buildNumberPad('5'),
                buildNumberPad('6'),
              ],
            ),
            TableRow(
              children: [
                buildNumberPad('7'),
                buildNumberPad('8'),
                buildNumberPad('9'),
              ],
            ),
            TableRow(
              children: [
                buildNumberPad('C'),
                buildNumberPad('0'),
                buildCheckButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
