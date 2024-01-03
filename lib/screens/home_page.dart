import 'package:flutter/material.dart';
import 'package:waypoing/data/data.dart';
import 'package:waypoing/widgets/single_circle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    SingleCircle.greenController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    SingleCircle.blueController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    SingleCircle.yellowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

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
              const SizedBox(height: 50),
              const Text('Animation duration'),
              AnimatedBuilder(
                  animation: animationController,
                  builder: (_, __) {
                    return Slider(
                      min: 200,
                      max: 1000,
                      label: animationController.duration?.inMilliseconds
                          .toString(),
                      value: double.parse(animationController
                          .duration!.inMilliseconds
                          .toString()),
                      onChanged: (value) {
                        animationController.duration =
                            Duration(milliseconds: value.toInt());

                        SingleCircle.blueController?.duration =
                            Duration(milliseconds: value.toInt());
                        SingleCircle.greenController?.duration =
                            Duration(milliseconds: value.toInt());
                        SingleCircle.yellowController?.duration =
                            Duration(milliseconds: value.toInt());

                        setState(() {});
                      },
                    );
                  }),
              Text(
                '${animationController.duration?.inMilliseconds} ms',
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
                singleCircleList.add(
                  const SingleCircle(
                    color: Colors.green,
                  ),
                );
                setState(() {});
              },
              child: const Text('Clear')),
        ],
      ),
    );
  }
}
