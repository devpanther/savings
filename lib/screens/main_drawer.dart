import 'package:flutter/material.dart';
import 'package:savings/controllers/authentications.dart';
import "package:savings/screens/sign_in/sign_in_screen.dart";
import 'package:savings/screens/home/components/string_extension.dart';

class MainDrawer extends StatefulWidget {
  final user;

  MainDrawer({Key key, @required this.user}) : super(key: key);
  @override
  _MainDrawerState createState() => _MainDrawerState(user);
}

class _MainDrawerState extends State<MainDrawer> {
  final user;
  _MainDrawerState(this.user);
  String get greet {
   var list = ["Hey", user.displayName.toString().capitalize()];
   list.removeWhere((v) => v == null);
   return list.join(" ");
  }
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.white12,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 40,bottom: 10
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/Profiler.png'),
                        fit: BoxFit.fill
                      ),
                    )
                  ),
                  Text(user.displayName.toString().capitalize(), 
                        style: TextStyle(fontSize: 22, color: Colors.blueAccent, fontWeight: FontWeight.w700)
                  ),
                  Text(user.email, 
                        style: TextStyle(color: Colors.blueAccent)
                  )
                ],
              ),
            )
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile", style: TextStyle(fontSize: 18)),
            onTap: () {
                Navigator.of(context).pop();
            }
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings", style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context).pop();
            }
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_outlined),
            title: Text("Log Out", style: TextStyle(fontSize: 18)),
            onTap: () => signOutUser().then((value) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (Route<dynamic> route) => false);
            }),
          )
        ],
      ),
    );
  }
}