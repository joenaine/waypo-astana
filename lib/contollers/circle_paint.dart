import 'dart:math';

import 'package:flutter/material.dart';

class CirclePaint extends CustomPainter {
  final Color? color;
  late final Animation<double> _size;
  late final Animation<double> _sizeCheck;

  CirclePaint(Animation<double> animation, this.color)
      : _size = Tween<double>(begin: 8, end: 0).animate(animation),
        _sizeCheck = Tween<double>(begin: -3, end: 1.5).animate(animation),
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    var circle = Paint()
      ..color = color!
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    var filledCircle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = false;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    final double radius = min(centerX, centerY) - 4;
    canvas.drawCircle(Offset(centerX, centerY), 10, circle);
    canvas.drawCircle(
      Offset(centerX, centerY),
      _size.value,
      filledCircle,
    );
    print(_size.value);

    final double iconSize = radius * _sizeCheck.value;
    final Offset iconOffset =
        Offset(centerX - iconSize / 2, centerY - iconSize / 2);
    const IconData iconData = Icons.check;
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          color: Colors.white,
          fontSize: iconSize,
          fontFamily: iconData.fontFamily,
          package: iconData.fontPackage,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, iconOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
