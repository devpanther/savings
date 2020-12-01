import 'package:flutter/material.dart';
import 'package:savings/components/custom_surfix_icon.dart';
import 'package:savings/components/default_button.dart';
import 'package:savings/components/form_error.dart';
import 'package:savings/controllers/authentications.dart';
import 'package:savings/screens/set_fingerprint/set_fingerprint.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';

class LockForm extends StatefulWidget {
  @override
  _LockFormState createState() => _LockFormState();
}

class _LockFormState extends State<LockForm> {
  final _formKey = GlobalKey<FormState>();
  String password;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(
            width: double.infinity,
            height: getProportionateScreenHeight(56),
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              color: Colors.white,
              onPressed: () {},
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                new Text(
                      "Login".toUpperCase(),
                      style: TextStyle(fontSize: getProportionateScreenWidth(16), color: Hexcolor("0043E0"),)
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _obscureText,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      style: TextStyle(
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelText: "Password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        labelStyle: TextStyle(color: Colors.white),
        focusColor: Colors.white,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          size: 18,
          color: Colors.white,
        ),
        suffixIcon: GestureDetector(
          onTap:  _toggle,
          child: Icon(
            _obscureText
            ? Icons.visibility
            : Icons.visibility_off,
            size: 18,
            color: Colors.white,
          ),
        ),
        
      ),
    );
  }
}