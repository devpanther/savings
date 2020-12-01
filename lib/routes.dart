import 'package:flutter/widgets.dart';
import 'package:savings/screens/forgot_password/forgot_password_screen.dart';
import 'package:savings/screens/home/home_screen.dart';
import 'package:savings/screens/sign_in/sign_in_screen.dart';
import 'package:savings/screens/sign_in/sign_up/sign_up_screen.dart';
import 'package:savings/screens/sign_in/lock_screen/lock_screen.dart';
import 'package:savings/screens/splash/splash_screen.dart';
import 'package:savings/screens/set_fingerprint/set_fingerprint.dart';
import 'package:firebase_auth/firebase_auth.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  SignInScreen.routeName: (context) => SignInScreen(),
  LockScreen.routeName: (context) => LockScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  SetFingerprintScreen.routeName: (context) => SetFingerprintScreen(),
  HomeScreen.routeName: (context) => (
    FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return HomeScreen(user: user);
        } else {
          return null;
        }
      },
    )
  ),
};
