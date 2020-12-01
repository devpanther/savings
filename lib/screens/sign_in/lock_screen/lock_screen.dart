import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'components/body.dart';
import 'package:flutter/services.dart';

class LockScreen extends StatelessWidget {
  static String routeName = "/lock";
  @override
  Widget build(BuildContext context) {
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
          statusBarColor: Hexcolor("0066F5"),
          statusBarIconBrightness: Brightness.light, //top bar icons
          systemNavigationBarColor: Hexcolor("0066F5"), //bottom bar color
          systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
        ), 
        child: Body(),
      ),
      backgroundColor: Hexcolor("0066F5"),
      ),
    );
  }
}
