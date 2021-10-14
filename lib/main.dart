import 'package:flutter/material.dart';

import 'ghflutter.dart';
import 'strings.dart';

void main() => runApp(const GHFlutterApp());

class GHFlutterApp extends StatelessWidget {
  const GHFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primaryColor: Colors.green.shade800),
      home: const GHFlutter(),
    );
  }
}
