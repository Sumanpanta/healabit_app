import "package:flutter/material.dart";
import 'dart:async';
import 'package:healabit_app/models/settings.dart';
import 'package:healabit_app/ui/allscreen/exercise_screen.dart';
import 'package:healabit_app/ui/allscreen/inout.dart';

class Ready extends StatefulWidget {
  final ModelSettings settings;
  Ready({super.key, required this.settings});

  _ReadyState createState() => _ReadyState();
}

class _ReadyState extends State<Ready> {
  late VoidCallback onBackPress;  //late modifier put

  @override
  void initState() {
    super.initState();
    
  }

  
  late Timer _timer;
  int _start = 3;
  bool _timeCheck =false;

  var now = new DateTime.now();

  void startTimer() {
    _timeCheck = true;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start == 1) {
            timer.cancel();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InOut(
                  settings: widget.settings,
                )),
            ); 
          } else {
            print(_start);
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!_timeCheck) startTimer();

    return Scaffold(
      backgroundColor: Color(0xFF85C1E9),
      body: new Center(
        child: new Text(_start.toString(),
          style: TextStyle(
            fontSize: 480,
            fontFamily: 'HK Grotesk',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}
