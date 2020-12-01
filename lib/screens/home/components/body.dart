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
import 'package:badges/badges.dart';
import 'package:savings/size_config.dart';
import 'package:flutter/services.dart';
import 'package:savings/screens/chat/home_screen.dart';

class Body extends StatefulWidget {
  final user;

  Body({Key key, @required this.user}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(user);
}

class _BodyState extends State<Body> {
  final user;
  int _index = 0;
  _BodyState(this.user);
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
              padding: EdgeInsets.only(left: 15, top: 5, bottom: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
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
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.displayName,
                              style: GoogleFonts.barlow(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                    ],
                  ),
                  Container(
                    width: 85,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                 GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatHomeScreen(user: user),
                                      ),
                                    );
                                  },
                                  child: FaDuotoneIcon(FontAwesomeIcons.duotoneUserHeadset, secondaryColor: Hexcolor("0066F5"), primaryColor: Hexcolor("0066F5").withOpacity(.4)),
                                ),
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
            SizedBox(height: getProportionateScreenHeight(10)),
            Container(
              height: 175,
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  // padding: EdgeInsets.only(left: 16, right: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: cards.length,
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (context, index) {
                   return Transform.scale(
                    scale: index == _index ? 1 : 0.93,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 175,
                      width: MediaQuery.of(context).size.width * 0.92,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Hexcolor("1573FF"),
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Color(0x10000000),
                        //       blurRadius: 10,
                        //       spreadRadius: 4,
                        //       offset: Offset(0.0, 8.0))
                        // ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 16,
                            top: 12,
                            child: Image.asset(
                              cards[index].type,
                              height: 22,
                              width: 33,
                            ),
                          ),
                          Positioned(
                            right: 12,
                            top: 12,
                            child:
                                SvgPicture.asset(cards[index].cardBackground),
                          ),
                          Positioned(
                            top: 14,
                            right: 12,
                            child: Text(
                              cards[index].name,
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 45,
                            right: 8,
                            child: Text(
                              'Your Balance',
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 15,
                            right: 8,
                            child: Text(
                              'NGN ' + cards[index].balance,
                              style: GoogleFonts.barlow(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                   );
                  }),
            ),

            // Last Transaction Section
            Padding(
            padding:
                EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Savings Progress',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kBlackColor,
                  ),
                ),
                Text(
                  'See all savings',
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
                'Recent Savings',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kBlackColor,
                ),
              ),
            ),
            Container(
              height: 304,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16, right: 16),
                itemCount: wallets.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 68,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x04000000),
                              blurRadius: 10,
                              spreadRadius: 10,
                              offset: Offset(0.0, 8.0))
                        ],
                        color: kWhiteColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kWhiteGreyColor,
                                image: DecorationImage(
                                  image: AssetImage(wallets[index].walletLogo),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  wallets[index].name,
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: kBlackColor),
                                ),
                                Text(
                                  wallets[index].wallet,
                                  style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: kGreyColor),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              wallets[index].walletNumber,
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: kGreyColor),
                            ),
                            SizedBox(
                              width: 16,
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
