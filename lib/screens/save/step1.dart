import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:savings/constants.dart';
import './step2.dart';

class Step1 extends StatefulWidget {
  final savingsType;

  Step1({Key key, @required this.savingsType}) : super(key: key);
  @override
  _Step1State createState() => _Step1State(savingsType);
}

class _Step1State extends State<Step1> {
  final savingsType;
  _Step1State(this.savingsType);
  bool isButtonDisabled = true;
  String amount;
  String name;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(""),
        actions: <Widget>[
            Row(
              children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Text("Step 1/5", style: GoogleFonts.barlow(fontWeight: FontWeight.bold,color: Hexcolor("000000")),)
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
                                "Goal Details",
                                style: GoogleFonts.barlow(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Hexcolor("1573FF")
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Goal Name and amount to save in TOTAL",
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 50),
                              Flexible(
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                        name = value;
                                    });
                                    if(int.parse(amount) >= 10000 && amount.isNotEmpty && value.isNotEmpty){
                                      setState(() {
                                        isButtonDisabled = false;
                                      });
                                    }else if(int.parse(amount) < 10000){
                                      setState(() {
                                        isButtonDisabled = true;
                                      });
                                    }else{
                                      
                                    }
                                  },
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    labelText: "Goal Name",
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
                              SizedBox(height: 20),
                              Flexible(
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                  ], // Only numbers can be entered
                                  onChanged: (value) {
                                    if(int.parse(value) >= 10000 && value.isNotEmpty && name.isNotEmpty){
                                      setState(() {
                                        isButtonDisabled = false;
                                      });
                                    }else if(int.parse(value) < 10000){
                                      setState(() {
                                        isButtonDisabled = true;
                                      });
                                    }else if(name.isEmpty){
                                      setState(() {
                                        isButtonDisabled = true;
                                      });
                                    }
                                    setState(() {
                                        amount = value;
                                    });
                                  }, 
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
                              SizedBox(height: 50),
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
                                        MaterialPageRoute(builder: (context) => Step2(amount: amount, name: name, savingsType: savingsType)),
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
    );
  }
}
