import 'package:flutter/material.dart';
import 'package:savings/components/socal_card.dart';
import 'package:savings/constants.dart';
import 'package:savings/size_config.dart';
import 'lock_form.dart';
import 'package:savings/components/load_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class Body extends StatelessWidget {
  LocalAuthentication localAuthentication = LocalAuthentication();

  bool canAuth = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
       child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Hexcolor("0066F5"),
          statusBarIconBrightness: Brightness.light, //top bar icons
          systemNavigationBarColor: Hexcolor("0066F5"), //bottom bar color
          systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
        ), 
        child: Align(
        alignment: Alignment.center,
        child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Welcome back, Gift",
                    style: TextStyle(fontWeight: FontWeight.bold, height: 1.5, fontSize: getProportionateScreenWidth(28), color: Colors.white,)),
                Text(
                  "Please, input your password to login",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: getProportionateScreenWidth(16), color: Colors.white,)
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                LockForm(),
                SizedBox(height: getProportionateScreenHeight(20)),
                SizedBox.fromSize(
                  size: Size(56, 56), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent, // button color
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
                              color: Colors.white,
                              size: 50,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: getProportionateScreenWidth(12), color: Colors.white,)
                ),
                SizedBox(height: getProportionateScreenHeight(40)),
              ],
            ),
          ),
        ),
      ),
      ),
      )
    );
  }
}
