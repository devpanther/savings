import 'package:flutter/material.dart';

import 'components/body.dart';

class SetFingerprintScreen extends StatelessWidget {
  static String routeName = "/set_fingerprint";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        
      ),
      body: Body(),
    );
  }
}
