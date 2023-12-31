import 'package:flutter/material.dart';
import 'package:healabit_app/ui/widgets/custom_flat_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;

  CustomAlertDialog({required this.title, required this.content, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          contentPadding: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: Text(
            title,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: "OpenSans",
            ),
          ),
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  content,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    decoration: TextDecoration.none,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: "OpenSans",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CustomFlatButton(
                    title: "OK",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black54,
                    onPressed: () {
                      onPressed();
                      Navigator.of(context).pop();
                    },
                    splashColor: Colors.black12,
                    borderColor: Colors.black12,
                    borderWidth: 2, color: Colors.black12, shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}