import 'package:flutter/material.dart';
import 'package:savings/screens/home/home_screen.dart';
import 'package:savings/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:savings/widgets/custom_dialog.dart';
import 'package:local_auth/local_auth.dart';


class Body extends StatelessWidget {
  LocalAuthentication localAuthentication = LocalAuthentication();

  bool canAuth = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/icons/security.svg", width: 100),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Text(
          "Fingerprint",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.w700,
            color: Hexcolor("0043E0"),
            fontFamily: "GTWalsheim"
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Text(
          "Add your fingerprint for \nmore security",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(19),
            color: Colors.grey,
            fontFamily: "GTWalsheim",
          ),
        ),
        Lottie.asset("assets/icons/finger.json", repeat: true, width: 300),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        SizedBox(
          width: SizeConfig.screenWidth * 0.5,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)),
              color: Colors.transparent,
              textColor: Hexcolor("0043E0"),
              padding: EdgeInsets.all(17.0),
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              child: Text(
                "Skip this step",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Avenir"
                ),
              ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        SizedBox(
          width: SizeConfig.screenWidth * 0.8,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(color: Hexcolor("0043E0"))),
              color: Hexcolor("0043E0"),
              textColor: Colors.white,
              padding: EdgeInsets.all(17.0),
              onPressed: () async {
                      List<BiometricType> list = List();
                      try {
                        if (canAuth) {
                          list = await localAuthentication.getAvailableBiometrics();

                          if (list.length > 0) {
                            bool result =
                                await localAuthentication.authenticateWithBiometrics(localizedReason:'Please enter your fingerprint to unlock',
                                      useErrorDialogs: true,
                                      stickyAuth: false);
                            result ? showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        pic: "assets/icons/register.json",
                        congrat: "Congratulations",
                        title: "Now You're Registered",
                        description:
                            "Get ready to save money with EasySave",
                        primaryButtonText: "Start Now",
                        primaryButtonRoute: "/home",
                      ),
                    ) : null;
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
              child: Text(
                "Continue",
                style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: "Avenir"
                ),
              ),
          ),
        ),
        Spacer(),
      ],
    ),
    );
  }
}
