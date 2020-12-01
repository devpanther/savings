import 'package:flutter/material.dart';

import '../size_config.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.assetss,
    this.press,
  }) : super(key: key);
  final String text;
  final String assetss;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Hexcolor("0066F5"),
        onPressed: press,
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          new Text(
                text.toUpperCase(),
                style: TextStyle(fontSize: getProportionateScreenWidth(16), color: Colors.white,)
          ),
          (assetss != null) ? Image.asset(
            assetss,
            height: 60.0,
            width: 60.0,
          ) : new Text(
                '',
          ),
          ],
        ),
      ),
    );
  }
}
