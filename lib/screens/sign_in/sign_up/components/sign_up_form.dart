import 'package:flutter/material.dart';
import 'package:savings/components/custom_surfix_icon.dart';
import 'package:savings/components/default_button.dart';
import 'package:savings/components/form_error.dart';
import 'package:savings/controllers/authentications.dart';
import 'package:savings/screens/set_fingerprint/set_fingerprint.dart';
import 'package:savings/components/load_button.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String fullName;
  String phoneNumber;
  String address;
  String email;
  String password;
  String conformPassword;
  bool remember = false;
  bool phoneval = false;
  bool emailval = false;
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

  void handleSignup() {
    FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) 
      { 
          currentFocus.focusedChild.unfocus(); 
      } 
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      signUp(email.trim(), password, fullName, context).then((value) {
        if (value != null) {
          Navigator.pushNamed(context, SetFingerprintScreen.routeName
                );
          animatedButtonController.completed(); // call when you get the response
          animatedButtonController.reset(); // call to reset button animation
        }
      });
    }else{
      animatedButtonController.reset(); // call to reset button animation
    }
  }
  final LoadButtonController animatedButtonController = LoadButtonController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFullNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          LoadButton(
              controller: animatedButtonController,
              text: 'Sign Up',
              loadingText: 'Signing Up',
              loadedIcon: Icon(Icons.check, color: Colors.white),
              onPressed: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) 
                  { 
                    currentFocus.focusedChild.unfocus(); 
                  } 
                  handleSignup();
              },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: _obscureText,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: kMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      style: TextStyle(
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelText: "Confirm Password",
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
          Icons.lock_outline,
          size: 18,
          color: Colors.blueAccent,
        ),
        suffixIcon: GestureDetector(
          onTap:  _toggle,
          child: Icon(
            _obscureText
            ? Icons.visibility
            : Icons.visibility_off,
            size: 18,
            color: Colors.blueAccent,
          ),
        ),
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
          Icons.lock_outline,
          size: 18,
          color: Colors.blueAccent,
        ),
        suffixIcon: GestureDetector(
          onTap:  _toggle,
          child: Icon(
            _obscureText
            ? Icons.visibility
            : Icons.visibility_off,
            size: 18,
            color: Colors.blueAccent,
          ),
        ),
        
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        setState(() {
          emailval = true;
        });
        return null;
      },
      style: TextStyle(
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelText: "Email",
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
          Icons.mail_outline,
          size: 18,
          color: Colors.blueAccent,
        ),
        suffixIcon: GestureDetector(
          onTap:  _toggle,
          child: Icon(
            emailval
            ? Icons.check
            : null,
            size: 18,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
}


  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        phoneNumber = value;
      },
      validator: (value) {
        String pattern = r'(^(?:[+0]234)?[0-9]{10,11}$)';
        RegExp regExp = new RegExp(pattern);
        if (value.length == 0) {
           addError(error: kPhoneNumberNullError);
          return "";
        }
        else if (!regExp.hasMatch(value)) {
           addError(error: kPhoneNumberNullError);
           return "";
        }
        setState(() {
          phoneval = true;
        });
        return null;
      },
      style: TextStyle(
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelText: "Phone Number",
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
          Icons.phone_outlined,
          size: 18,
          color: Colors.blueAccent,
        ),
        suffixIcon: GestureDetector(
          child: Icon(
            phoneval
            ? Icons.check
            : null,
            size: 18,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }


  TextFormField buildFullNameFormField() {
    return TextFormField(
      onSaved: (newValue) => fullName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        fullName = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      style: TextStyle(
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelText: "Full Name",
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
          Icons.person_outlined,
          size: 18,
          color: Colors.blueAccent,
        ),
      ),
    );
}
}