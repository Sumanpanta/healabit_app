// import 'dart:ffi';

import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final Color color;
  final double size;

  const CircleButton({Key? key, required this.onTap, required this.color, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        // child: new Icon(
        //   iconData,
        //   color: Colors.black,
        // ),
      ),
    );
  }
}