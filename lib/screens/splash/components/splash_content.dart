import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.text2,
    this.image,
  }) : super(key: key);
  final String text,text2, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(flex: 2),
        Image.asset(image, width: 260),   
        Spacer(flex: 1),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.barlow(
                  fontSize: getProportionateScreenWidth(26),
                  fontWeight: FontWeight.bold,
                  color: Colors.black
          ),
        ),
        Spacer(flex: 2),
        Text(
          text2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: getProportionateScreenWidth(14), fontWeight: FontWeight.w700, color: Colors.grey)
        )
      ],
    );
  }
}
