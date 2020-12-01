import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
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
        body: Body(),
      ),
    );
  }
}
