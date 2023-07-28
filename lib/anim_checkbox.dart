import 'package:flutter/material.dart';

class AnimatedCheckbox extends StatefulWidget {
  @override
  _AnimatedCheckboxState createState() => _AnimatedCheckboxState();
}

class _AnimatedCheckboxState extends State<AnimatedCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 00));
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
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Animated Checkbox'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _toggleCheckbox,
          child: AnimatedCheckboxPainter(
            animation: _animationController,
            isChecked: _isChecked,
          ),
        ),
      ),
    );
  }
}

class AnimatedCheckboxPainter extends StatelessWidget {
  final Animation<double> animation;
  final bool isChecked;

  const AnimatedCheckboxPainter(
      {required this.animation, required this.isChecked})
      : super();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CheckboxPainter(
        isChecked: isChecked,
        checkmarkProgress: animation.value,
      ),
      size: const Size.square(40.0),
    );
  }
}

class _CheckboxPainter extends CustomPainter {
  final bool isChecked;
  final double checkmarkProgress;

  _CheckboxPainter({required this.isChecked, this.checkmarkProgress = 0.0})
      : super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - paint.strokeWidth / 2;

    // Draw the outer circle
    canvas.drawCircle(center, radius, paint);

    // Draw the checkmark when isChecked is true and animation is complete (1.0)
    if (isChecked && checkmarkProgress == 1.0) {
      final checkmarkPaint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0;

      final checkmarkLength = size.width / 3;
      final checkmarkStart = Offset(center.dx - checkmarkLength / 2, center.dy);
      final checkmarkEnd = Offset(center.dx, center.dy + checkmarkLength);

      canvas.drawLine(checkmarkStart, checkmarkEnd, checkmarkPaint);

      const checkmarkAngle = -45.0;
      final checkmarkPath = Path()
        ..moveTo(checkmarkEnd.dx, checkmarkEnd.dy)
        ..lineTo(checkmarkEnd.dx, checkmarkEnd.dy)
        ..lineTo(checkmarkEnd.dx - checkmarkLength * 0.4,
            checkmarkEnd.dy + checkmarkLength * 0.4)
        ..close();

      canvas.drawPath(checkmarkPath, checkmarkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
