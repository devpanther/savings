import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import './step4.dart';
import 'package:savings/size_config.dart';
import 'package:flutter/services.dart';

class Step3 extends StatefulWidget {
  final amount;
  final type;
  final name;
  final savingsType;
  Step3({Key key, @required this.amount, @required this.type, @required this.name, @required this.savingsType}) : super(key: key);
  @override
  _Step3State createState() => _Step3State(amount, type, name, savingsType);
}

class _Step3State extends State<Step3> {
  final amount;
  final type;
  final name;
  final savingsType;
  String enterAmount;
  _Step3State(this.amount, this.type, this.name, this.savingsType);
  bool isButtonDisabled = true;
  @override

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
                    child: Text("Step 3/5", style: GoogleFonts.barlow(fontWeight: FontWeight.bold,color: Hexcolor("000000")),)
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
                                "Select Amount",
                                style: GoogleFonts.barlow(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Hexcolor("1573FF")
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(20)),
                              Text(
                                "How much can you save EACH MONTH for this goal?",
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: getProportionateScreenHeight(45)),
                              customRadio('Fair - NGN ${(5/100)*int.parse(amount)} (5% of income)','${(5/100)*int.parse(amount)}'),
                              SizedBox(height: getProportionateScreenHeight(25)),
                              customRadio('Good - NGN ${(10/100)*int.parse(amount)} (10% of income)','${(10/100)*int.parse(amount)}'),
                              SizedBox(height: getProportionateScreenHeight(25)),
                              customRadio('Best - NGN ${(15/100)*int.parse(amount)} (15% of income)','${(15/100)*int.parse(amount)}'),
                              SizedBox(height: getProportionateScreenHeight(25)),
                              Text(
                                "OR",
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: getProportionateScreenHeight(25)),
                              TextField(
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                  ], // Only numbers can be entered
                                  onChanged: (value) {
                                    if(int.parse(value) >= (5/100)*int.parse(amount) && value.isNotEmpty){
                                      setState(() {
                                        isButtonDisabled = false;
                                        selectedIndex = value;
                                      });
                                    }else if(value.length <= (5/100)*int.parse(amount) && value.isNotEmpty){
                                      setState(() {
                                        isButtonDisabled = true;
                                      });
                                    }
                                    setState(() {
                                        enterAmount = value;
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
                                SizedBox(height: getProportionateScreenHeight(25)),
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
                                          MaterialPageRoute(builder: (context) => Step4(amount: amount, savingsType: savingsType, type: type, savings: selectedIndex, name: name)),
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