import 'package:flutter/material.dart';
import 'package:savings/components/no_account_text.dart';
import 'package:savings/components/socal_card.dart';
import '../../../size_config.dart';
import 'package:savings/screens/sign_in/lock_screen/lock_screen.dart';
import 'sign_form.dart';
import 'package:local_auth/local_auth.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<Body> {
  LocalAuthentication localAuthentication = LocalAuthentication();
  bool canAuth = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),
                // RaisedButton(
                //   onPressed: () async {
                //     canAuth = await localAuthentication.canCheckBiometrics;
                //     print(canAuth.toString());
                //   },
                //   child: Center(child: Text('Check')),
                // ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                SizedBox.fromSize(
                  size: Size(56, 56), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.green, // splash color
                        onTap: () async {
                            List<BiometricType> list = List();
                            try {
                              if (canAuth) {
                                list = await localAuthentication.getAvailableBiometrics();

                                if (list.length > 0) {
                                  bool result =
                                      await localAuthentication.authenticateWithBiometrics(localizedReason:'Please enter your fingerprint to unlock',
                                            useErrorDialogs: true,
                                            stickyAuth: false);
                                  print('resultis $result');
                                  if (list.contains(BiometricType.fingerprint)) {
                                    print('fingerprint');
                                  }
                                  if (list.contains(BiometricType.iris)) {
                                    print('iris');
                                  }
                                  if (list.contains(BiometricType.face)) {
                                    print('face unlock');
                                  }
                                }
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.fingerprint,
                              color: Colors.blue,
                              size: 50,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LockScreen()),
                        );
                      },
                    ),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    SocalCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
                SizedBox(height: getProportionateScreenHeight(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
