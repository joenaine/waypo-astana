import 'dart:math';

import 'package:flutter/material.dart';

class CheckboxWithFillingAnimation extends StatefulWidget {
  @override
  _CheckboxWithFillingAnimationState createState() =>
      _CheckboxWithFillingAnimationState();
}

class _CheckboxWithFillingAnimationState
    extends State<CheckboxWithFillingAnimation>
    with SingleTickerProviderStateMixin {
  bool _isChecked = false;
  late AnimationController _circleAnimationController;
  late Animation<double> _circleAnimation;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
      if (_isChecked) {
        _animationController.forward(from: 0);
      } else {
        _animationController.reverse(from: 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox with Filling Animation'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _toggleCheckbox,
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: CheckboxPainter(
                    isChecked: _isChecked,
                    animationValue: _animation.value,
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.orange,
        width: double.infinity,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: _animation.value,
          child: Container(
            color: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }
}

class CheckboxPainter extends CustomPainter {
  final bool isChecked;
  final double animationValue;

  CheckboxPainter({required this.isChecked, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = min(centerX, centerY) - 4;
    final Rect rect =
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius);

    if (isChecked) {
      // canvas.drawCircle(Offset(centerX, centerY), radius, paint);
      final Paint fillPaint = Paint()..color = Colors.orange;
      canvas.drawCircle(Offset(centerX, centerY), radius, fillPaint);
      canvas.drawCircle(Offset(centerX, centerY), radius, paint);
      final double iconSize = radius * (0.5 + 0.5 * animationValue);
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
    } else {
      canvas.drawArc(rect, 0, 2 * pi, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
