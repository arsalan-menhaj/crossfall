// core
import 'package:flutter/material.dart';
import 'dart:math';

// custom widgets
import 'package:crossfall/falling_shape.dart';

const numberOfColumns = 4;

List<Column> generateColumns() {
  final List<Column> columns = [];
  var rand = Random();

  for (int i = 0; i < numberOfColumns; i++) {
    columns.add(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FallingShape(
          delay: rand.nextInt(4),
          startingIndex: rand.nextInt(4),
        ),
      ],
    ));
  }

  return columns;
}

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
  final List<Container> shapeColumns = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: SizedBox(
          width:
              numberOfColumns * 2 * (MediaQuery.of(context).size.height) / 15,
          child: Wrap(
            direction: Axis.horizontal,
            children: generateColumns(),
          ),
        ));
  }
}
