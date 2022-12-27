import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:async';

const shapeChangeIntervalSeconds = 3;

final List<String> svgNames = [
  'circle-svgrepo-com.svg',
  'triangle-svgrepo-com.svg',
  'square-bold-svgrepo-com.svg',
  'close-svgrepo-com.svg'
];
final List<Widget> svgList = svgNames
    .map((name) => SvgPicture.asset(
          name,
        ))
    .toList();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Crossfall';

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
  bool _isPressed = false;
  Timer? switchTimer;

  void updateShapeState() {
    if (!_isPressed) {
      setState(() {
        if (_currentIndex < svgNames.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switchTimer?.cancel();
    switchTimer = Timer.periodic(
        const Duration(seconds: shapeChangeIntervalSeconds), (timer) {
      timer.cancel();
      updateShapeState();
    });

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: _isPressed ? Colors.blueAccent : Colors.white),
            onPressed: () {
              setState(() {
                _isPressed = !_isPressed;
              });
            },
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                switchOutCurve: Curves.linear,
                switchInCurve: Curves.linear,
                child: SizedBox(
                    width: 200,
                    height: 200,
                    key: ValueKey<int>(_currentIndex),
                    child: svgList[_currentIndex])),
          ),
        ],
      ),
    );
  }
}
