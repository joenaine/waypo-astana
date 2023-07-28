import 'package:flutter/material.dart';
import 'package:waypoing/widgets/single_circle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    SingleCircle.greenController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    SingleCircle.blueController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    SingleCircle.yellowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SingleCircle(
            color: Colors.green,
          ),
          SingleCircle(
            color: Colors.green,
          ),
          SingleCircle(
            color: Colors.yellow,
          ),
          SingleCircle(
            color: Colors.yellow,
          ),
          SingleCircle(
            color: Colors.blue,
          ),
          SingleCircle(
            color: Colors.blue,
          ),
          SingleCircle(
            color: Colors.blue,
          ),
        ],
      ),
    ));
  }
}
