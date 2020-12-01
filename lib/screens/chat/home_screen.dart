import 'package:flutter/material.dart';
import 'package:savings/widgets/recent_chats.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savings/screens/home/home_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class ChatHomeScreen extends StatefulWidget {
  final user;

  ChatHomeScreen({Key key, @required this.user}) : super(key: key);
  @override
  _ChatHomeScreenState createState() => _ChatHomeScreenState(user);
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final user;
  _ChatHomeScreenState(this.user);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Hexcolor("0066F5"),
          statusBarIconBrightness: Brightness.light, //top bar icons
          systemNavigationBarColor: Colors.white, //bottom bar color
          systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
        ),
        child: DoubleBackToCloseApp(
          child: Container(
          color: Hexcolor("0066F5"),
          child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 15, top: 76, bottom: 42),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(user: user),
                              ),
                            );
                          },
                          child: FaDuotoneIcon(FontAwesomeIcons.duotoneChevronLeft, primaryColor: Colors.white, secondaryColor: Colors.white.withOpacity(.9)),
                        ),
                        SizedBox(width: 12),
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.05),
                                  blurRadius: 8,
                                  spreadRadius: 1)
                            ],
                            border: Border.all(
                              width: 1.5,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: SvgPicture.asset("assets/images/avatar.svg")
                        ),
                        SizedBox(width: 13),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jacob",
                              style: GoogleFonts.barlow(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Investment Expert",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withOpacity(.8)),
                            ),
                          ],
                        ),
                    ],
                  ),
                  Container(
                    width: 72,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              FaDuotoneIcon(FontAwesomeIcons.duotoneEllipsisHAlt, primaryColor: Colors.white, secondaryColor: Colors.white.withOpacity(.4)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  RecentChats(),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                        onChanged: (value) {
                          
                        },
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: "Enter A Message",
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          labelStyle: TextStyle(color: Colors.blueAccent),
                          focusColor: Colors.blueAccent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Hexcolor("0066F5"), 
                              width: 1.0
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Hexcolor("0066F5"), width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Hexcolor("0066F5"), width: 1.0),
                          ),
                          suffixIcon: Icon(
                            Icons.send_rounded,
                            size: 18,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
          snackBar: const SnackBar(
            content: Text('Use the top back button to go back'),
          ),
        ),
      ),
    );
  }
}