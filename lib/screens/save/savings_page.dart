import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savings/constants.dart';
import 'package:savings/models/card_model.dart';
import 'package:savings/models/transaction_model.dart';
import 'package:savings/models/wallet_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savings/screens/main_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:savings/screens/save/cards_savings.dart';
import 'package:savings/components/default_button.dart';
import 'package:badges/badges.dart';
import 'package:savings/size_config.dart';
import 'package:flutter/services.dart';
import './step1.dart';

class SavingsPage extends StatefulWidget {
  final user;

  SavingsPage({Key key, @required this.user}) : super(key: key);
  @override
  _SavingsPageState createState() => _SavingsPageState(user);
}

class _SavingsPageState extends State<SavingsPage> {
  final user;
  int _index = 0;
  _SavingsPageState(this.user);
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
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            // Card Account Section
            SizedBox(height: getProportionateScreenHeight(30)),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 4, bottom: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                        Container(
                    width: 40.0,
                    height: 40.0,
                    child: SvgPicture.asset("assets/images/piggy-bank.svg")
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Savings",
                        style: GoogleFonts.barlow(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "NGN 5000",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Hexcolor("0066F5")),
                      ),
                    ],
                  )
                    ],
                  ),
                  Container(
                    width: 85,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                FaDuotoneIcon(FontAwesomeIcons.duotoneUserHeadset, secondaryColor: Hexcolor("0066F5"), primaryColor: Hexcolor("0066F5").withOpacity(.4)),
                                SizedBox(width: 15),
                                Badge(
                                  badgeContent: Text('3', style: TextStyle(color: Colors.white)),
                                  child: FaDuotoneIcon(FontAwesomeIcons.duotoneBell, primaryColor: Hexcolor("0066F5"), secondaryColor: Hexcolor("0066F5").withOpacity(.4))
                                ),
                              ]
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Last Transaction Section
            Padding(
            padding:
                EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Recent Savings',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kBlackColor,
                  ),
                ),
                Text(
                  'See all transactions',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: kBlueColor,
                  ),
                ),
              ],
            )),
            SizedBox(height: 20),
            Container(
              height: 190,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16, right: 8, bottom: 4, top: 4),
                scrollDirection: Axis.horizontal,
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 190,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kWhiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x04000000),
                            blurRadius: 10,
                            spreadRadius: 10,
                            offset: Offset(0.0, 8.0))
                      ],
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 16,
                          left: 16,
                          child: SvgPicture.asset(transactions[index].type),
                          height: 24,
                          width: 24,
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child:
                              SvgPicture.asset('assets/svg/mastercard_bg.svg'),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Text(
                            transactions[index].name,
                            style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: transactions[index].colorType),
                          ),
                        ),
                        Positioned(
                          top: 64,
                          left: 16,
                          child: Text(
                            transactions[index].signType +
                                'Rp ' +
                                transactions[index].amount,
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: transactions[index].colorType),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          top: 106,
                          child: Text(
                            transactions[index].information,
                            style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: kGreyColor),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 48,
                          child: Text(
                            transactions[index].recipient,
                            style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: kBlackColor),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 22,
                          child: Text(
                            transactions[index].date,
                            style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: kGreyColor),
                          ),
                        ),
                        Positioned(
                          right: 14,
                          bottom: 16,
                          child: Image.asset(
                            transactions[index].card,
                            height: 22,
                            width: 33,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // Top Up Section
            Padding(
              padding:
                  EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
              child: Text(
                'Select a goal',
                style: GoogleFonts.nunito(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: kBlackColor,
                ),
              ),
            ),
            CardPage(
              icons: FontAwesomeIcons.duotoneCalendarDay,
              title: 'Regular Savings',
              press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Step1(savingsType: 'Regular Savings')));
              },
              subtitle: 'Save money on your terms for a minimum of 3 months. We\'ll reward your discipline with juicy returns',
            ),
            CardPage(
              icons: FontAwesomeIcons.duotoneSirenOn,
              title: 'Emergency Funds',
              press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Step1(savingsType: 'Emergency Funds')));
              },
              subtitle: 'Save money on your terms for a minimum of 3 months. We\'ll reward your discipline with juicy returns',
            ),
            CardPage(
              icons: FontAwesomeIcons.duotoneIslandTropical,
              title: 'Vacation',
              press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Step1(savingsType: 'Vacation Savings')));
              },
              subtitle: 'Save money on your terms for a minimum of 3 months. We\'ll reward your discipline with juicy returns',
            ),
            SizedBox(height: 10),
            Center(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                borderSide: BorderSide(color: Hexcolor("0066F5"), width: .3),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
                onPressed: () {},
                child: Text("Create my own goal",
                    style: TextStyle(
                        fontSize: 16, color: Hexcolor("0066F5"), fontWeight: FontWeight.w700)),
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
      )
    );
  }
}
