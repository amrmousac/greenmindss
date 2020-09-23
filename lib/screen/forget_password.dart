import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/network/forget_password.dart';
import 'package:greenminds/screen/reset_password.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:toast/toast.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 108.h,
            right: 50.w,
            left: 50.w,
            child: Text(
              'Please, Enter your email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'your email',
                ),
                style: TextStyle(color: Colors.white),
                controller: email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
          Builder(
            builder: (context) => Positioned(
              bottom: 230.h,
              left: 200.w,
              right: 200.w,
              child: RaisedButton(
                onPressed: () async {
                  Toast.show("sending", context,
                      duration: Toast.LENGTH_LONG,
                      backgroundColor: Colors.yellow.withOpacity(0.8),
                      gravity: Toast.CENTER);
                  try {
                    print(email.text);
                    bool isConfirmed = await forgetPassword(email.text);
                    if (isConfirmed) {
                      Toast.show("Success", context,
                          duration: Toast.LENGTH_LONG,
                          backgroundColor:
                              AppUtilities.appGreen.withOpacity(0.8),
                          gravity: Toast.CENTER);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPasswordScreen()));
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Email not exist')));
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
            ),
          )
        ],
      ),
    );
  }
}
