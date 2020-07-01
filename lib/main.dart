import 'package:flutter/material.dart';
import 'package:kauntaa/watch_home.dart';

void main() => runApp(KauntaApp());

class KauntaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WatchHome());
  }
}
