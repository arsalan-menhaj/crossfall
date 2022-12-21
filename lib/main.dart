import 'package:flutter/material.dart';
import 'package:crossfall/shapes/rounded_rectangle_painter.dart';
import 'package:crossfall/shapes/triangle_painter.dart';

final List<String> svgNames = [
  'square-svgrepo-com.svg',
  'triangle-fill-svgrepo-com.svg',
  'triangle-svgrepo-com.svg'
];

final List<Widget> shapeList = [
  CustomPaint(painter: TrianglePainter()),
  CustomPaint(painter: RoundedRectanglePainter()),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _currentIndex = 0;
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return RotationTransition(turns: animation, child: child);
              },
              switchOutCurve: Curves.easeInOutCubic,
              switchInCurve: Curves.easeInOutCubic,
              // child: SizedBox(
              //     width: 300, height: 300, child: shapeList[_currentIndex])),
              child: Text('$_counter')),
          ElevatedButton(
            child: const Text('Increment'),
            onPressed: () {
              setState(() {
                // if (_currentIndex < 1) {
                //   _currentIndex++;
                // } else {
                //   _currentIndex = 0;
                // }
                _counter++;
              });
            },
          ),
        ],
      ),
    );
  }
}
