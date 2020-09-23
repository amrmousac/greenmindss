import 'dart:async';
import 'package:flutter/material.dart';
import 'package:greenminds/models/login_response_success.dart';
import 'package:greenminds/network/login.dart';
import 'package:greenminds/screen/home.dart';
import 'package:greenminds/screen/pin_confirm.dart';
import 'package:greenminds/screen/register.dart';
import 'package:greenminds/screen/sign_in.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

Future<void> allowLogin(context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAllowed = prefs.getBool('isAllowedToLogin') ?? false;
    if (isAllowed) {
      String user = prefs.getString('user') ?? '';
      String pass = prefs.getString('pass') ?? '';
      LoginResponseSuccess responseSuccess = await login(user, pass);
      if (responseSuccess != null) {
        if (responseSuccess.emailConfirmed == "False") {
          Timer(Duration(milliseconds: 500), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PinConfirmScreen()));
          });
        } else {
          Timer(Duration(milliseconds: 500), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          });
        }
      } else {
        Timer(Duration(milliseconds: 500), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignInScreen()));
        });
      }
    } else {
      Timer(Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RegisterScreen()));
      });
    }
  } catch (e) {
    Timer(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RegisterScreen()));
    });
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    allowLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/images/logorow.png',
              width: 540.w,
            )),
      ),
    );
  }
}
