import "package:flutter/material.dart";

class Walkthrough {
  IconData icon;
  String title;
  String description;
  Widget extraWidget;
  
  Walkthrough({required this.icon, required this.title, required this.description, required this.extraWidget}) {
    if (extraWidget == null) {
      extraWidget = new Container();
    }
  }
}