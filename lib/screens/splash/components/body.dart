import 'package:flutter/material.dart';
import 'package:savings/constants.dart';
import 'package:savings/screens/sign_in/sign_in_screen.dart';
import 'package:savings/screens/sign_in/sign_up/sign_up_screen.dart';
import 'package:savings/size_config.dart';
// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';
import '../../../components/outline_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Save for anything\n with Goals",
      "text2": "Welcome to EasySave!",
      "image": "assets/images/saving-money.gif"
    },
    {
      "text": "Save for anything\n with Goals",
      "text2": "Learn to spend Wisely",
      "image": "assets/images/spend-money.gif"
    },
    {
      "text": "Save for anything\n with Goals",
      "text2": "Keep track of your Savings",
      "image": "assets/images/calendar.gif"
    },
    {
      "text": "Save for anything\n with Goals",
      "text2": "Invest Money On The Go",
      "image": "assets/images/money-tree.gif"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.screenHeight * 0.06),
            Image.asset('assets/images/logo.png', width: 140),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                  text2: splashData[index]['text2'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    // Spacer(flex: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 1),
                    DefaultButton(
                      text: "Get Started",
                      press: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    DefaultOutlineButton(
                      text: "Sign In",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
