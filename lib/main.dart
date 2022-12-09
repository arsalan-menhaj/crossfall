import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final dir = new Directory('../assets');
String fileListString = '';

Future<void> main() async {
  List<FileSystemEntity> fileList = await dir.list().toList();
  fileListString = fileList.map((e) => e.path).join(',');

  runApp(const MyApp());
}

//void main() => runApp(const MyApp());

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
  int _count = 0;

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
            child: Text(
              '$_count',
              // This key causes the AnimatedSwitcher to interpret this as a "new"
              // child each time the count changes, so that it will begin its animation
              // when the count changes.
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          ElevatedButton(
            child: const Text('Increment'),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          ),
          Text(fileListString)
        ],
      ),
    );
  }
}
