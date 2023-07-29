import 'package:flutter/material.dart';
import 'package:waypoing/widgets/single_circle.dart';

final pageBucket = PageStorageBucket();

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

  ScrollController controller = ScrollController();

  List<SingleCircle> singleCircleList = [
    const SingleCircle(
      color: Colors.green,
    ),
  ];

  List<SingleCircle> addCirclesList = [
    const SingleCircle(
      color: Colors.green,
    ),
    const SingleCircle(
      color: Colors.green,
    ),
    const SingleCircle(
      color: Colors.yellow,
    ),
    const SingleCircle(
      color: Colors.yellow,
    ),
    const SingleCircle(
      color: Colors.blue,
    ),
    const SingleCircle(
      color: Colors.blue,
    ),
    const SingleCircle(
      color: Colors.green,
    ),
    const SingleCircle(
      color: Colors.blue,
    ),
    const SingleCircle(
      color: Colors.yellow,
    ),
    const SingleCircle(
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: singleCircleList.map((e) => e).toList(),
              ),
              Slider(
                label: '1',
                value: 1,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                addCirclesList.shuffle();
                singleCircleList.addAll(addCirclesList);
                setState(() {});
              },
              child: const Text('Add Checkbox')),
          TextButton(
              onPressed: () {
                singleCircleList.clear();
                setState(() {});
              },
              child: const Text('Clear')),
        ],
      ),
    );
  }
}

class PositionRetainedScrollPhysics extends ScrollPhysics {
  final bool shouldRetain;
  const PositionRetainedScrollPhysics(
      {ScrollPhysics? parent, this.shouldRetain = true})
      : super(parent: parent);

  @override
  PositionRetainedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PositionRetainedScrollPhysics(
      parent: buildParent(ancestor),
      shouldRetain: shouldRetain,
    );
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    final position = super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );

    final diff = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;
    if (oldPosition.pixels == 0) {
      if (newPosition.maxScrollExtent > oldPosition.maxScrollExtent &&
          diff > 0 &&
          shouldRetain) {
        return diff;
      } else {
        return position;
      }
    } else {
      return position;
    }
  }
}
