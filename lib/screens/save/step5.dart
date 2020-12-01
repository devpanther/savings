import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import './step4.dart';
import 'package:savings/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:savings/components/default_button.dart';

class Step5 extends StatefulWidget {
  final amount;
  final type;
  final savings;
  final duration;
  final name;
  final savingsType;

  Step5({Key key, @required this.amount, @required this.type, @required this.savings, this.duration, @required this.name, @required this.savingsType}) : super(key: key);
  @override
  _Step5State createState() => _Step5State(amount, type, savings, duration, name, savingsType);
}

class _Step5State extends State<Step5> {
  final amount;
  final type;
  final savings;
  final duration;
  final name;
  final savingsType;
  bool autopay = false;
  _Step5State(this.amount, this.type, this.savings, this.duration, this.name, this.savingsType);
  bool isButtonDisabled = true;

  _modalBottomSheetMenu(context){
      showModalBottomSheet(
          context: context,
          enableDrag: false,
          isDismissible: false,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
              borderRadius : BorderRadius.circular(20)
          ),
          builder: (BuildContext context) {
            return new AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: MediaQuery.of(context).size.height / 2,
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
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context)
                                },
                                child: Text(
                                "Close",
                                style: GoogleFonts.barlow(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Hexcolor("0047AB")
                                ),
                              ),
                              ),
                              FaDuotoneIcon(FontAwesomeIcons.duotoneHorizontalRule),
                              SizedBox(height: 30),
                              Text(
                                "Add Goal Amount",
                                style: GoogleFonts.barlow(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Hexcolor("0047AB")
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "How much do you need to save in TOTAL?",
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 20),
                              Flexible(
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "Enter Amount",
                                    // If  you are using latest version of flutter then lable text and hint text shown like this
                                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                                    labelStyle: TextStyle(color: Colors.blueAccent),
                                    focusColor: Colors.blueAccent,
                                    filled: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.blueAccent),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.money_outlined,
                                      size: 18,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              DefaultButton(
                                text: "Next",
                                press: () {
                                    _modalBottomSheetMenu(context);
                                },
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
            ),);
          },
        );
  }


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
                    child: Text("Step 5/5", style: GoogleFonts.barlow(fontWeight: FontWeight.bold,color: Hexcolor("000000")),)
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
                                "Review Details",
                                style: GoogleFonts.barlow(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Hexcolor("1573FF")
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(30)),
                              Card(
                                elevation: 2,
                                color: Hexcolor("1573FF"),
                                child: ClipPath(
                                  child: Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                    border: Border(right: BorderSide(color: Colors.blueAccent, width: 5))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 18.0, top: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: getProportionateScreenHeight(8)),
                                              Text(name.toUpperCase(),
                                                style: GoogleFonts.barlow(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                                ),
                                              ),
                                              Text(savingsType,
                                                style: TextStyle (
                                                    color: Colors.white,
                                                    fontSize: 12
                                                ),
                                              ),
                                              SizedBox(height: getProportionateScreenHeight(8)),
                                              Divider(
                                                color: Colors.white
                                              ),
                                              SizedBox(height: getProportionateScreenHeight(10)),
                                              Text('Goal Amount: NGN ${amount}',
                                              style: GoogleFonts.barlow(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                                ),
                                              ),
                                              SizedBox(height: getProportionateScreenHeight(10)),
                                              Text('Save Type: ${type}',
                                              style: GoogleFonts.barlow(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                                ),
                                              ),
                                              SizedBox(height: getProportionateScreenHeight(10)),
                                              Text('${type} Payment: NGN ${savings}',
                                              style: GoogleFonts.barlow(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                                ),
                                              ),
                                              SizedBox(height: getProportionateScreenHeight(10)),
                                              Text('Duration: ${duration}',
                                              style: GoogleFonts.barlow(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                                ),
                                              ),
                                            ],
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3))),
                                  ),
                                ),
                                Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 10),
                                      child: buildNotificationOptionRow("Enable Automatic Debit"),
                                ),
                                SizedBox(height: getProportionateScreenHeight(50)),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                    color: Colors.transparent,
                                    textColor: Hexcolor("0043E0"),
                                    onPressed: () {
                                      
                                    },
                                    child: Text(
                                      "I'll save when i want to",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Avenir"
                                      ),
                                    ),
                                ),
                                Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DefaultButton(
                                      text: "Pay Now",
                                      press: () {
                                          _modalBottomSheetMenu(context);
                                      },
                                    ),
                                ),
                          ],
                        ),
                      ),
                  ],
                ),
            ),),),
    );
  } 

  Row buildNotificationOptionRow(String title) {
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
              value: autopay,
              onChanged: (bool val) {
                setState(() {
                  autopay = val;
                });
              },
            ))
      ],
    );
  }

}
