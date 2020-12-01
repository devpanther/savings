import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.white));
  return GestureDetector(
    onTap: () { 
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) 
        { 
          currentFocus.focusedChild.unfocus(); 
        } 
    },
    child: Scaffold(
      body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark, //top bar icons
            systemNavigationBarColor: Colors.white, //bottom bar color
            systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
          ),
          child: Body(),
        ),
    ),);
  }
}
