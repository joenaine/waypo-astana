import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(),
      body: Center(child: AnimatedCircle()),
    );
  }
}

class AnimatedCircle extends StatefulWidget {
  @override
  _AnimatedCircleState createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Set the animation duration here
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: CirclePainter(_animation.value),
          child: Container(), // Add any child widgets you need here
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  final double animationValue;

  CirclePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;
    final paintCircle = Paint()
      ..color = Colors.orange
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final maxRadius = size.width / 2;
    final currentRadius = animationValue * maxRadius;

    canvas.drawCircle(center, maxRadius, paint);

    // Use a ClipRect to fill up the circle from the border to the center
    // canvas.clipRect(Rect.fromCircle(center: center, radius: currentRadius));
    canvas.drawCircle(center, currentRadius, paintCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CircleAnimationPainter extends CustomPainter {
  final double animationValue; // Value from 0.0 to 1.0 to control the animation

  CircleAnimationPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 5.0; // Adjust the stroke width as needed

    final paint = Paint()
      ..color = Colors.blue // Replace this with the desired fill color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final fillPaint = Paint()
      ..color = Colors.blue // Replace this with the desired fill color
      ..style = PaintingStyle.fill;

    final animatedRadius = radius * animationValue;

    // Draw the outer circle (stroke)
    canvas.drawCircle(center, radius, paint);

    // Draw the inner circle (fill) with an increasing radius based on the animation value
    canvas.drawCircle(center, animatedRadius, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CircleAnimationScreen extends StatefulWidget {
  @override
  _CircleAnimationScreenState createState() => _CircleAnimationScreenState();
}

class _CircleAnimationScreenState extends State<CircleAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 2), // Adjust the animation duration as needed
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Circle')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return CustomPaint(
              painter: CircleAnimationPainter(_animationController.value),
              child: SizedBox(
                width: 200,
                height: 200,
              ),
            );
          },
        ),
      ),
    );
  }
}
