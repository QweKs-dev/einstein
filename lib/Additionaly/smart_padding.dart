import 'package:flutter/material.dart';

class SmartPadding extends StatelessWidget {
  Widget child;
  double widthFactor;
  double heightFactor;

  SmartPadding({Key key, this.child, this.widthFactor = 1, this.heightFactor = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      double wf, hf;
      if (widthFactor != null)
        wf = constrains.maxWidth * (1.0 - widthFactor) / 2.0;
      if (heightFactor != null)
        hf = constrains.maxHeight * (1.0 - heightFactor) / 2.0;
      return Padding(
          child: child,
          padding: EdgeInsets.symmetric(horizontal: wf, vertical: hf ?? wf));
    });
  }
}
