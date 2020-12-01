import 'package:flutter/material.dart';
import 'package:savings/size_config.dart';
import 'package:hexcolor/hexcolor.dart';

const kPrimaryColor = Color(0xFF0149C1);
const kActiveIconColor = Color(0xFFE68342);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 500);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
const primary = Color(0xFFF391A0);
const grey = Color(0xFFe9eaec);
const white = Color(0xFFFFFFFF);
const black = Color(0xFF000000);
const online = Color(0xFF66BB6A);
const blue_story = Colors.blueAccent;
// Colors
const kBlueColor = Color(0xFF6E8AFA);
const kBestSellerColor = Color(0xFFFFD073);
const kGreenColor = Color(0xFF49CC96);
const kBackgroundColor = Color(0xffF6F6F6);
const kAccentColor = Color(0xff03A5E1);
const kBlackColor = Color(0xFF212121);
const kGreyColor = Color(0x50212121);
const kWhiteColor = Color(0xFFFFFFFF);
const kWhiteGreyColor = Color(0xFFF9F9F9);
const kOrangeColor = Color(0xFFFF9C41);
const kJeniusCardColor = Color(0xFF03A5e1);
const kMasterCardColor = Color(0xFFF5F5F5);
const kGradientSlideButton = [const Color(0xFF3B64F4), const Color(0xFF6822FD)];
// My Text Styles
const kHeadingextStyle = TextStyle(
  fontSize: 28,
  color: kPrimaryColor,
  fontWeight: FontWeight.w700,
);
const kSubheadingextStyle = TextStyle(
  fontSize: 20,
  color: Color(0xFF61688B),
  height: 2,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kSubtitleTextSyule = TextStyle(
  fontSize: 18,
  color: kTextColor,
  // fontWeight: FontWeight.bold,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
