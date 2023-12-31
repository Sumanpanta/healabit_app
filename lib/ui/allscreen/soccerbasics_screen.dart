import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healabit_app/models/user.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healabit_app/models/settings.dart';
import 'package:healabit_app/ui/allscreen/ready_screen.dart';
import 'package:healabit_app/ui/allscreen/main_screen.dart';
import 'package:healabit_app/ui/allscreen/video_screen.dart';
import 'package:healabit_app/ui/widgets/custom_circle_button.dart';
import 'package:healabit_app/ui/widgets/custom_flat_button.dart';

class SoccerBasics extends StatefulWidget {
  final FireBaseUser firebaseUser;
  final ModelSettings settings;

  SoccerBasics({required this.firebaseUser, required this.settings});
  _SoccerBasicsState createState() => _SoccerBasicsState();
}

class _SoccerBasicsState extends State<SoccerBasics> {

  late VoidCallback onBackPress; //late modifier


  @override
  void initState() {

    super.initState();
    print(widget.settings);
  }

  @override
  void dispose() {

    super.dispose();
  }

  var now = new DateTime.now();

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          new Image.network(
            document['url'],
            height: 100.0,
          ),
          
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  document['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text("Rest"),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(document['durationTime'] + "s"),
                new Text(document['restTime'] + "s"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  settings: widget.settings,
                )),
            )),
        title: Text(
          'Preview',
          textAlign: TextAlign.center,  
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('exercise1').orderBy('no').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                child: Stack(
                                  children: <Widget> [
                                    new Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: new Image.asset('assets/images/preview.jpg', fit: BoxFit.fitWidth),
                                    ),
                                    Positioned(
                                      left: 20,
                                      bottom: 20,
                                      child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Text(new DateFormat.yMMMd('en_US').format(now),
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          new Text("NASCAR",
                                            style: TextStyle(
                                              color: Colors.white, 
                                              fontSize: 24, 
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          new Text("16Mins. | HIIT | Beginner",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ),
                                  ]
                                ),
                                onTap: () {
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: new Text("Warm-ups to use",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _warmupButton(Colors.black45, "3 min", 'https://www.youtube.com/watch?v=HDfvWrGUkC8'),
                                  // _warmupButton(Colors.black45, "test", 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
                                  _warmupButton(Colors.black, "12 min", 'https://www.youtube.com/watch?v=iqbbwFYXjFc&t=617s'),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return _buildList(context, snapshot.data?.hashCode as DocumentSnapshot<Object?>);
                      }
                    },
                  ); 
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                elevation: 16,
                child: Container(
                  height: 320.0,
                  // width: 1000.0,
                  child: new Center(
                    child: new Container(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: new Text("Get Ready",
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text("Turn on the music and get ready to start your workout.", 
                            overflow: TextOverflow.clip, 
                            style: TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ButtonTheme(
                              minWidth: 200.0,
                              // height: 100.0,
                              child: CustomFlatButton(      //error
                                title: "I'm ready!",
                                fontSize: 20,
                                textColor: Colors.black,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Ready(
                                        settings: widget.settings,
                                      )),
                                  );
                                },
                                splashColor: Colors.black12,
                                borderColor: Color(0xFFDCE2ED),
                                borderWidth: 0,
                                color: Color(0xFFDCE2ED), fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ButtonTheme(
                              minWidth: 200.0,
                              // height: 100.0,
                              child: CustomFlatButton(                   //error
                                title: "Need more time",
                                fontSize: 20,
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                splashColor: Colors.black12,
                                borderColor: Color(0xFF3A5998),
                                borderWidth: 0,
                                color: Color(0xFF3A5998),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), 
                ),
              );
            }
          );
        },
        label: new Text("  Start Workout  ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _warmupButton(Color color, String txt, String url) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          child: new CircleButton(
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    settings: widget.settings,
                    url: url,
                  )),
              );
            },
            color: color,
            size: 25.0,
          ),
        ),
        new Text(txt,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}