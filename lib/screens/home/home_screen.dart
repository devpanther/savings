import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:savings/controllers/authentications.dart';
import 'components/body.dart';
import 'package:savings/size_config.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:savings/screens/home/components/transfer_page.dart';
import 'package:savings/screens/settings/settings.dart';
import 'package:savings/screens/save/savings_page.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class HomeScreen extends StatefulWidget {
  final user;

  HomeScreen({Key key, @required this.user}) : super(key: key);
  
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState(user);
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItemIndex = 0;

  final user;
  _HomeScreenState(this.user);
  var _transferPage;
  var _homePage;
  var _settingsPage;
  var _savingsPage;
  Widget _showPage;
  void initState() {
    super.initState();
    _transferPage = new TransferPage(user: user);
    _homePage = new Body(user: user);
    _showPage = new Body(user: user);
    _settingsPage = new SettingsPage(user: user);
    _savingsPage = new SavingsPage(user: user);
  }


  Widget _pageChooser(int page){
    switch (page){
      case 0:
      return _homePage;
      break;
      case 1:
      return _transferPage;
      break;
      case 2:
      return _savingsPage;
      break;
      case 4:
      return _settingsPage;
      break;
      default:
      return new Container(
        child: new Center(
          child: new Text(
            "No page found",
            style: TextStyle(fontSize: 30)
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        bottomNavigationBar: Row(
          children: [
            buildNavBarItem(FontAwesomeIcons.duotoneHome, 0, "Home"),
            buildNavBarItem(FontAwesomeIcons.duotoneRocket, 1, "Trade"),
            buildNavBarItem(FontAwesomeIcons.duotoneWallet, 2, "Save"),
            buildNavBarItem(FontAwesomeIcons.duotoneReceipt, 3, "Transactions"),
            buildNavBarItem(FontAwesomeIcons.duotoneUser, 4, "Account"),
          ],
        ),
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.light, //top bar icons
            systemNavigationBarColor: Colors.white, //bottom bar color
            systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
          ),
          child: DoubleBackToCloseApp(
          child: _showPage,
          snackBar: const SnackBar(
            content: Text('Tap back again to exit'),
          ),
        ),
      ),
    );
  }
  buildNavBarItem(IconData icon, int index, String text) {
    return Container(
      decoration: BoxDecoration(
         border: Border(top: BorderSide(width: .5, color: Hexcolor("d2d2d2"))),
      ),
      child: InkWell(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
        setState(() {
          _showPage = _pageChooser(index);
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 60,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(width: 2, color: Hexcolor("0066F5"))),
                gradient: LinearGradient(colors: [
                  Hexcolor("0066F5").withOpacity(0.014),
                  Hexcolor("0066F5").withOpacity(0.02),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : BoxDecoration(
              color: Colors.white,
            ),
        // child: Icon(
        //   icon,
        //   color: index == _selectedItemIndex ? Color(0XFF00B868) : Colors.grey,
        // ),
        // Text(
        //   "Home"
        // )
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FaDuotoneIcon(
              icon,
              primaryColor: index == _selectedItemIndex ? Colors.blue : Hexcolor("d2d2d2"),
              secondaryColor: index == _selectedItemIndex ? Hexcolor("0066F5") : Colors.grey,
            ),
            SizedBox(height: 3),
            Text(
              text,
              style: index == _selectedItemIndex
            ? TextStyle(fontWeight: FontWeight.w700, fontSize: 10, color: Hexcolor("0066F5"))
            : TextStyle(fontWeight: FontWeight.w700, fontSize: 10)
            )
          ],
        ),
      ),
    ),
    );
  }
}
