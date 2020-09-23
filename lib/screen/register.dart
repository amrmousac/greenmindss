import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/logorow.png',
                      width: 540.w,
                      fit: BoxFit.contain,
                    ))),
            Container(
              padding: EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    },
                    color: Colors.white,
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Color(0xff9CC026)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
