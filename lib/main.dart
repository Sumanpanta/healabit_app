import 'package:flutter/material.dart';
import 'package:healabit_app/ui/allscreen/settings_screen.dart';
import 'package:healabit_app/ui/allscreen/walk_screen.dart';
import 'package:healabit_app/ui/allscreen/root_screen.dart';
import 'package:healabit_app/ui/allscreen/sign_in_screen.dart';
import 'package:healabit_app/ui/allscreen/sign_up_screen.dart';
import 'package:healabit_app/ui/allscreen/main_screen.dart';
import 'package:healabit_app/ui/allscreen/soccerbasics_screen.dart';
import 'package:healabit_app/ui/allscreen/exercise_screen.dart';
import 'package:healabit_app/ui/allscreen/inout.dart';
import 'package:healabit_app/ui/allscreen/report_screen.dart';
import 'package:healabit_app/ui/allscreen/reset_password_screen.dart';
import 'package:healabit_app/ui/allscreen/ready_screen.dart';
import 'package:healabit_app/ui/allscreen/video_screen.dart';
import 'package:healabit_app/ui/allscreen/activity.dart';
import 'package:healabit_app/ui/allscreen/insideoutside.dart';
import 'package:healabit_app/ui/allscreen/nascarresults.dart';
import 'package:healabit_app/ui/allscreen/profile.dart';
import 'package:healabit_app/ui/allscreen/totalworkouts.dart';
//import 'package:healabit_app/ui/allscreen/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.instance.settings(persistenceEnabled: true);
  // Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/walkthrough': (BuildContext context) => new WalkthroughScreen(),
        '/root': (BuildContext context) => new RootScreen(),
        '/signin': (BuildContext context) => new SignInScreen(),
        '/signup': (BuildContext context) => new SignUpScreen(),
        '/main': (BuildContext context) => new MainScreen(),
        '/soccerbasics': (BuildContext context) => new SoccerBasics(),
        '/exercise': (BuildContext context) => new Exercise(),
        '/report': (BuildContext context) => new Report(),
        '/resetpassword': (BuildContext context) => new ResetPassword(),
        '/ready': (BuildContext context) => new Ready(),
        '/settings': (BuildContext context) => new SettingsScreen(),
        '/video': (BuildContext context) => new VideoPlayerScreen(),
        '/activity': (BuildContext context) => new ActivityScreen(),
        '/insideoutside': (BuildContext context) => new InsideOutside(),
        '/nascarresults': (BuildContext context) => new NascarResultsScreen(),
        '/profile': (BuildContext context) => new ProfileScreen(),
        '/totalworkouts': (BuildContext context) => new TotalWorkouts(),
        '/inout': (BuildContext context) => new InOut(),
      },
      theme: ThemeData(
        primaryColor: Colors.white,
        // primarySwatch: Colors.grey,
        primarySwatch: Colors.green,
        hintColor: Colors.white,
      ),
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    // bool seen = (prefs.getBool('seen') ?? false);
    // if (true) {
      return new RootScreen();
    // } else {
    //   return new WalkthroughScreen(prefs: prefs);
    // }
  }
}
