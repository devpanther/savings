import 'package:flutter/material.dart';
import 'package:savings/routes.dart';
import 'package:savings/screens/splash/splash_screen.dart';
import 'package:savings/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savings/screens/home/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.white));
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KudiSmart',
      theme: theme(),
      home: FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(
                automaticallyImplyLeading: false, // hides leading widget
              )
            ),
            body: AnnotatedRegion(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                systemNavigationBarColor: Colors.white
              ),
              child: HomeScreen(user: user),
            ),
          );
        } else {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(
                automaticallyImplyLeading: false, // hides leading widget
              )
            ),
            body: AnnotatedRegion(
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  systemNavigationBarColor: Colors.white
                ),
                child: Splash(),
              ),
          );
        }
      },
    ),
    // We use routeName so that we dont need to remember the name
    routes: routes,
    );
  }
}
