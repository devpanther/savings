import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import './step5.dart';
import 'package:savings/size_config.dart';
import 'package:savings/components/default_button.dart';
import 'package:flutter/services.dart';

class Step4 extends StatefulWidget {
  final amount;
  final type;
  final savings;
  final name;
  final savingsType;

  Step4({Key key, @required this.amount, @required this.type, @required this.savings, @required this.name, @required this.savingsType}) : super(key: key);
  @override
  _Step4State createState() => _Step4State(amount, type, savings, name, savingsType);
}

class _Step4State extends State<Step4> {
  final amount;
  final type;
  final savings;
  final name;
  final savingsType;
  _Step4State(this.amount, this.type, this.savings, this.name, this.savingsType);
  bool isButtonDisabled = true;
  List<String> lst = ['3 Months','6 Months','1 Year'];
  String selectedIndex = null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(""),
        actions: <Widget>[
            Row(
              children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Text("Step 4/5", style: GoogleFonts.barlow(fontWeight: FontWeight.bold,color: Hexcolor("000000")),)
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
                                "How long would you like to save?",
                                style: GoogleFonts.barlow(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Hexcolor("1573FF")
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(45)),
                              customRadio(lst[0],'3 Months'),
                              SizedBox(height: getProportionateScreenHeight(25)),
                              customRadio(lst[1],'6 Months'),
                              SizedBox(height: getProportionateScreenHeight(25)),
                              customRadio(lst[2],'1 Year'),
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
                                          MaterialPageRoute(builder: (context) => Step5(amount: amount, savingsType: savingsType, type: type, savings: savings, duration: selectedIndex, name: name)),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                ),
                              // SizedBox(height: getProportionateScreenHeight(25)),
                              // Text(
                              //   "OR",
                              //   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                              // ),
                              // SizedBox(height: getProportionateScreenHeight(25)),
                              // DefaultButton(
                              //   text: "Select Preferred Duration",
                              //   press: () {
                                  
                              //   },
                              // ),
                              // Text(
                              //   "You can always change this later",
                              //   style: TextStyle(fontSize: 9, fontWeight: FontWeight.w300),
                              // ),
                          ],
                        ),
                      ),
                  ],
                ),
            ),),),
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