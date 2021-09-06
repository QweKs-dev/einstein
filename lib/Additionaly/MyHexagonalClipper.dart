import 'package:flutter/material.dart';

class MyHexagonalClipper extends CustomClipper<Path> {
  final bool reverse;

  MyHexagonalClipper({this.reverse = false});

  @override
  Path getClip(Size size) {
    var halfOfHeight = size.height / 2.0;
      final path = Path()
        ..lineTo(0.0, halfOfHeight)
        ..lineTo(halfOfHeight, size.height)
        ..lineTo(size.width - halfOfHeight, size.height)
        ..lineTo(size.width, halfOfHeight)
        ..lineTo(size.width - halfOfHeight, 0.0)
        ..lineTo(halfOfHeight, 0.0)
        ..lineTo(0.0, halfOfHeight)
        ..close();
      return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
