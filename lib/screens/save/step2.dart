import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import './step3.dart';
import 'package:savings/size_config.dart';
import 'package:flutter/services.dart';

class Step2 extends StatefulWidget {
  final amount;
  final name;
  final savingsType;

  Step2({Key key, @required this.amount, @required this.name, @required this.savingsType}) : super(key: key);
  @override
  _Step2State createState() => _Step2State(amount, name, savingsType);
}

class _Step2State extends State<Step2> {
  final amount;
  final name;
  final savingsType;
  _Step2State(this.amount, this.name, this.savingsType);
  bool isButtonDisabled = true;

  @override

  List<String> lst = ['Daily','Weekly','Monthly'];
  String selectedIndex = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        actions: <Widget>[
            Row(
              children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Text("Step 2/5", style: GoogleFonts.barlow(fontWeight: FontWeight.bold,color: Hexcolor("000000")),)
                  ),
              ],
            )
          ],
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.light, //top bar icons
          systemNavigationBarColor: Colors.white, //bottom bar color
          systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
        ), 
        child: SingleChildScrollView(
        child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              SizedBox(height: 30),
                              Text(
                                "Select save type",
                                style: GoogleFonts.barlow(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Hexcolor("1573FF")
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "How often do you want to save?",
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: getProportionateScreenHeight(40)),
                              customRadio(lst[0],'Daily'),
                              SizedBox(height: getProportionateScreenHeight(20)),
                              customRadio(lst[1],'Weekly'),
                              SizedBox(height: getProportionateScreenHeight(20)),
                              customRadio(lst[2],'Monthly'),
                              SizedBox(height: getProportionateScreenHeight(20)),
                              Text(
                                "You can always change this later",
                                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w300),
                              ),
                              SizedBox(height: getProportionateScreenHeight(40)),
                              AbsorbPointer(
                                absorbing: isButtonDisabled,
                                child: ClipOval(
                                child: Material(
                                  color: isButtonDisabled ? Colors.grey : Hexcolor("0066F5"), // button color
                                  child: InkWell(
                                    splashColor: Colors.blue, // inkwell color
                                    child: SizedBox(width: 56, height: 56, child: Icon(Icons.arrow_forward_ios, color: Colors.white)),
                                    onTap: () {
                                       Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Step3(amount: amount, savingsType: savingsType, type: selectedIndex, name: name)),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
            ),
      ),
      ),
    );
  }

   void changeIndex(String index){
    setState(() {
      selectedIndex = index;
    });
    setState(() {
      isButtonDisabled = false;
    });
  }
  Widget customRadio(String txt,String index){
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: OutlineButton(
      onPressed: () => changeIndex(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(color: selectedIndex == index ?  Hexcolor("0047AB") : Colors.grey),
      child: Text(txt,style: TextStyle(color: selectedIndex == index ? Hexcolor("0047AB") : Colors.grey, fontWeight: FontWeight.bold),),
    ),
    );
  }
}

class Company {
  const Company(this.name);
  final String name;
}