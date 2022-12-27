// core
import 'package:flutter/material.dart';

// custom widgets
import 'package:crossfall/falling_shape.dart';

const numberOfColumns = 4;

List<Container> generateColumns() {
  final List<Container> columns = [];

  for (int i = 0; i < numberOfColumns; i++) {
    columns.add(Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          FallingShape(),
        ],
      ),
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
    return Row(
      children: generateColumns(),
    );
  }
}
