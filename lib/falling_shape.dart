// core
import 'package:flutter/material.dart';
import 'dart:async';

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
  const FallingShape({super.key});

  @override
  State<FallingShape> createState() => _FallingShapeState();
}

class _FallingShapeState extends State<FallingShape>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isPressed = false;
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
