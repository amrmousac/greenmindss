import 'package:flutter/material.dart';
import 'package:greenminds/models/login_response_success.dart';
import 'package:greenminds/network/login.dart';
import 'package:greenminds/screen/forget_password.dart';
import 'package:greenminds/screen/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/screen/pin_confirm.dart';
import 'package:greenminds/screen/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController(),
      password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1440.h,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 216.h,
                left: 90.w,
                child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/logorow.png',
                      width: 540.w,
                      fit: BoxFit.contain,
                    )),
              ),
              Positioned(
                left: 28.8.h,
                right: 28.8.h,
                top: 560.h,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: userName,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your username or email';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration:
                              InputDecoration(labelText: 'username or email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'password'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPasswordScreen()));
                              },
                              child: Text('Forget password?',
                                  style:
                                      TextStyle(color: Colors.lightBlueAccent)),
                            ),
                            Builder(
                              builder: (context) => RaisedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    try {
                                      LoginResponseSuccess responseSuccess =
                                          await login(
                                              userName.text, password.text);
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          'token', responseSuccess.accessToken);
                                      prefs.setBool('isAllowedToLogin', true);
                                      prefs.setString(
                                          'email', responseSuccess.email);
                                      prefs.setString(
                                          'user', responseSuccess.username);
                                      prefs.setString('pass', password.text);

                                      if (responseSuccess.emailConfirmed ==
                                          "False") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PinConfirmScreen()));
                                      } else {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));
                                      }
                                    } catch (e) {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'something Error Please try again later')));
                                    }
                                  }
                                },
                                child: Text(
                                  'Go',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 50.h,
                  child: Container(
                    width: 720.h,
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen())),
                      child: Text(
                        "Don't have an account? Create new one",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
