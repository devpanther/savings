import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:savings/components/form_error.dart';
import 'package:savings/screens/forgot_password/forgot_password_screen.dart';
import 'package:savings/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savings/components/load_button.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'dart:io';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  String loading;
  
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

  bool _isInternet = true;

  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('example.com'); // google
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
        setState(() {});
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
      setState(() {});
    }
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  void _showToast(BuildContext context, String err) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        elevation: 6.0,
        behavior: SnackBarBehavior.floating,
        content: Text(err),
        backgroundColor: Colors.red,
      ),
    );
  }
  
  Future<FirebaseUser> signin(
    String email, String password, BuildContext context) async {
  try {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    // return Future.value(true);
    return Future.value(user);
  } catch (e) {
    // simply passing error code as a message
    print(e.code);
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
        _showToast(context, e.code);
        break;
      case 'ERROR_WRONG_PASSWORD':
         _showToast(context, e.code);
        break;
      case 'ERROR_USER_NOT_FOUND':
         _showToast(context, e.code);
        break;
      case 'ERROR_USER_DISABLED':
         _showToast(context, e.code);
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
         _showToast(context, e.code);
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
         _showToast(context, e.code);
        break;
    }
    // since we are not actually continuing after displaying errors
    // the false value will not be returned
    // hence we don't have to check the valur returned in from the signin function
    // whenever we call it anywhere
    return Future.value(null);
  }
}

  void login () {
    if(_isInternet){
      FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) 
    { 
      currentFocus.focusedChild.unfocus(); 
    } 
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      signin(email, password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(user: value),
              )
          );
          animatedButtonController.completed(); // call when you get the response
          animatedButtonController.reset(); // call to reset button animation
        }else{
          animatedButtonController.reset(); // call to reset button animation
        }
      });
    }else{
      animatedButtonController.reset();
    }
    } else{
      _showToast(context, 'No Internet Connection');
      animatedButtonController.reset();
    }
  }

  // Initially password is obscure
  bool _obscureText = true;
  final LoadButtonController animatedButtonController = LoadButtonController();
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
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          LoadButton(
              controller: animatedButtonController,
              text: 'Log In',
              loadingText: 'Logging In',
              loadedIcon: Icon(Icons.check, color: Colors.white),
              onPressed: () {
                login();
              },
          ),
          // DefaultButton(
          //   text: "Continue",
          //   press: () {
          //     FocusScopeNode currentFocus = FocusScope.of(context);
          //       if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) 
          //       { 
          //         currentFocus.focusedChild.unfocus(); 
          //     } 
          //     login();
          //   },
          //   assetss: loading,
          // ),
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
        } else if (value.length >= 7) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 7) {
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
            email != null
            ? Icons.check
            : null,
            size: 18,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}

