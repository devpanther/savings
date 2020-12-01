import 'package:flutter/material.dart';
import 'package:savings/screens/splash/components/body.dart';
import 'package:savings/size_config.dart';


class Splash extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // You have to call it on your starting screen
    return Scaffold(
      body: Body(),
    );
  }
}
