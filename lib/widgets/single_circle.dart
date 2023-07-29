import 'package:flutter/material.dart';
import 'package:waypoing/contollers/circle_paint.dart';

class SingleCircle extends StatefulWidget {
  final Color? color;
  static Color? colorOfWidget;
  static bool isFilled = true;
  static AnimationController? greenController;
  static AnimationController? yellowController;
  static AnimationController? blueController;
  const SingleCircle({Key? key, this.color}) : super(key: key);

  @override
  _SingleCircleState createState() => _SingleCircleState();
}

class _SingleCircleState extends State<SingleCircle>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    if (widget.color == Colors.green) {
      animationController = SingleCircle.greenController;
    } else if (widget.color == Colors.blue) {
      animationController = SingleCircle.blueController;
    } else {
      animationController = SingleCircle.yellowController;
    }

    super.initState();
  }

  // @override
  // void dispose() {
  //   animationController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (SingleCircle.isFilled) {
            animationController?.forward();
          } else {
            animationController?.reverse();
          }
          SingleCircle.isFilled = !SingleCircle.isFilled;
        },
        child: CustomPaint(
          size: const Size(25, 25),
          painter: CirclePaint(animationController!.view, widget.color),
        ));
  }
}
