import 'package:flutter/material.dart';
import 'package:flutter_wear/mode.dart';
import 'package:flutter_wear/wear_mode.dart';
import 'package:flutter_wear/wear_shape.dart';
import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _containerColor;
  Color _textColor;
  RandomColor _randomColor = RandomColor();

  int _counter = 0;
  @override
  void initState() {
    super.initState();
    _getLastValue();
    _containerColor = _randomColor.randomColor();
    _textColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          backgroundColor: _containerColor,
          body: Center(
            child: WearShape(
              builder: (context, shape) {
                return WearMode(
                  builder: (context, mode) {
                    if (mode == Mode.active) {
                      _textColor = Colors.black;
                    } else {
                      _containerColor = Colors.black;
                      _textColor = Colors.white;
                    }

                    return Container(
                      color: _containerColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$_counter',
                              style: TextStyle(
                                  color: _textColor,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: _counterPressed,
                            child: Text('Count!'),
                          ),
                          GestureDetector(
                            child: Text('reset'),
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setInt('counter', 0);
                              setState(() {
                                _counter=0;
                              });
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _counterPressed() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = (prefs.getInt('counter') ?? 0);
    setState(() {
      _counter++;
      _containerColor = _randomColor.randomColor();
    });
    await prefs.setInt('counter', _counter);
  }

  _getLastValue() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = (prefs.getInt('counter') ?? 0);
  }
}
