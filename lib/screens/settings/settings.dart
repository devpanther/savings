import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savings/screens/main_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:savings/controllers/authentications.dart';
import "package:savings/screens/sign_in/sign_in_screen.dart";
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  final user;

  SettingsPage({Key key, @required this.user}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState(user);
}

class _SettingsPageState extends State<SettingsPage> {
  final user;
  _SettingsPageState(this.user);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark, //top bar icons
          systemNavigationBarColor: Colors.white, //bottom bar color
          systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
        ), 
        child: Container(
        padding: EdgeInsets.only(left: 19, top: 25, right: 19),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                        "My Account",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                      Text(
                        user.displayName,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                  ],
                ),
                SvgPicture.asset("assets/images/user.svg", width: 40)
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                FaDuotoneIcon(
                  FontAwesomeIcons.duotoneUser,
                  primaryColor: Colors.blue,
                  secondaryColor: Hexcolor("0066F5"),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Change password"),
            buildAccountOptionRow(context, "Content settings"),
            buildAccountOptionRow(context, "Social"),
            buildAccountOptionRow(context, "Language"),
            buildAccountOptionRow(context, "Privacy and security"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                FaDuotoneIcon(
                  FontAwesomeIcons.duotoneBells,
                  primaryColor: Colors.blue,
                  secondaryColor: Hexcolor("0066F5"),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("New for you", true),
            buildNotificationOptionRow("Account activity", true),
            buildNotificationOptionRow("Opportunity", false),
            SizedBox(
              height: 50,
            ),
            Center(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                borderSide: BorderSide(color: Hexcolor("0066F5"), width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () => signOutUser().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                      (Route<dynamic> route) => false);
                }),
                child: Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Hexcolor("0066F5"))),
              ),
            )
          ],
        ),
      ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.grey[600],
              ),
            ),
            FaDuotoneIcon(
              FontAwesomeIcons.duotoneChevronRight,
              primaryColor: Hexcolor("d2d2d2"),
              secondaryColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}