import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/network/forget_password.dart';
import 'package:greenminds/network/reset_password.dart';
import 'package:greenminds/screen/sign_in.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toast/toast.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController code = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Reset password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.w, vertical: 4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'your email',
                    ),
                    style: TextStyle(color: Colors.white),
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.w, vertical: 4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'new password',
                    ),
                    style: TextStyle(color: Colors.white),
                    controller: password,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.w, vertical: 4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'confirm new password',
                    ),
                    style: TextStyle(color: Colors.white),
                    controller: confirmPassword,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.w, vertical: 4.0),
                  child: PinCodeTextField(
                    controller: code,
                    length: 4,
                    textInputType: TextInputType.number,
                    onChanged: (String value) {},
                    textStyle: TextStyle(color: Colors.white),
                    backgroundColor: Colors.transparent,
                    pinTheme: PinTheme(shape: PinCodeFieldShape.box),
                  ),
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) => RaisedButton(
              onPressed: () async {
                Toast.show("sending", context,
                    duration: Toast.LENGTH_LONG,
                    backgroundColor: Colors.yellow.withOpacity(0.8),
                    gravity: Toast.CENTER);
                try {
                  print(email.text);
                  bool isConfirmed = await resetPassword(email.text,
                      password.text, confirmPassword.text, code.text);
                  if (isConfirmed) {
                    Toast.show("Success", context,
                        duration: Toast.LENGTH_LONG,
                        backgroundColor: AppUtilities.appGreen.withOpacity(0.8),
                        gravity: Toast.CENTER);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                            'something wrong, Make sure that all fields are correct \n Note:The Password must be at least 6 characters long.')));
                  }
                } catch (e) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content:
                          Text('something Error, Please try again later')));
                }
              },
              child: Text(
                'Summit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
