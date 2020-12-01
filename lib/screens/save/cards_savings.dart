import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:savings/components/default_button.dart';
import './step1.dart';
import 'package:savings/size_config.dart';

class CardPage extends StatelessWidget {
  const CardPage({
    Key key,
    this.icons,
    this.title,
    this.subtitle,
    this.press,
  }) : super(key: key);
  final IconData icons;
  final String title;
  final String subtitle;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
        color: Hexcolor("99ccff").withOpacity(.7),
        child: ClipPath(
          child: Container(
        height: 185,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.92,
          decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.blueAccent, width: 5
                )
              )
          ),
          child: Stack(
            children: <Widget>[
              // Positioned(
              //   left: 16,
              //   top: 12,
              //   child: Image.asset(
              //     "xvbxc",
              //     height: 22,
              //     width: 33,
              //   ),
              // ),
              Positioned(
                left: 16,
                top: 15,
                right: 8,
                child: FaDuotoneIcon(
                  icons, 
                  primaryColor: Hexcolor("0066F5"), 
                  secondaryColor: Hexcolor("0066F5").withOpacity(.4)
                ),
              ),
              Positioned(
                left: 16,
                top: 55,
                right: 8,
                child: Text(
                  title,
                  style: GoogleFonts.barlow(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Hexcolor("0047AB")),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 25,
                right: 8,
                child: Text(
                  subtitle,
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Hexcolor('00008B')),
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
    );
  }
}
