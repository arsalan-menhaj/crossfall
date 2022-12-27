// core
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:io';

// external packages
import 'package:flutter_svg/flutter_svg.dart';

const shapeChangeIntervalSeconds = 1;
const fallTimeSeconds = 2;

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

class FallingShape extends StatefulWidget {
  final int delay;
  final int startingIndex;

  const FallingShape(
      {super.key, required this.delay, required this.startingIndex});

  @override
  State<FallingShape> createState() => _FallingShapeState();
}

class _FallingShapeState extends State<FallingShape>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isPressed = false;
  bool _isFirstLoad = true;
  Timer? switchTimer;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: fallTimeSeconds),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -5.0),
    end: const Offset(0.0, 5.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  void updateShapeState() {
    if (!_isPressed) {
      setState(() {
        _currentIndex = Random().nextInt(svgList.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstLoad) {
      _currentIndex = widget.startingIndex;
      _isFirstLoad = false;
    }

    switchTimer?.cancel();
    switchTimer = Timer.periodic(
        const Duration(seconds: shapeChangeIntervalSeconds), (timer) {
      timer.cancel();
      updateShapeState();
    });

    return SlideTransition(
      position: _offsetAnimation,
      child: ElevatedButton(
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
                height: (MediaQuery.of(context).size.height) / 10,
                width: (MediaQuery.of(context).size.height) / 15,
                key: ValueKey<int>(_currentIndex),
                child: svgList[_currentIndex])),
      ),
    );
  }
}
