import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/models/signup_response_fail.dart';
import 'package:greenminds/models/signup_response_success.dart';
import 'package:greenminds/network/signup.dart';
import 'package:greenminds/screen/pin_confirm.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController(),
      userName = TextEditingController(),
      email = TextEditingController(),
      country = TextEditingController(),
      phoneNumber = TextEditingController(),
      password = TextEditingController(),
      confirmPassword = TextEditingController();
  ScaffoldState _scaffoldState = ScaffoldState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1440.h,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 150.h,
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
                top: 400.h,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: name,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: userName,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(labelText: 'userName'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your userName';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: email,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(labelText: 'email'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: country,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(labelText: 'country'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your country';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: password,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            obscureText: true,
                            decoration: InputDecoration(labelText: 'password'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: confirmPassword,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            obscureText: true,
                            decoration:
                                InputDecoration(labelText: 'confirm password'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Builder(
                          builder: (context) => RaisedButton(
                            onPressed: () async {
                              try {
                                if (_formKey.currentState.validate()) {
                                  var signupReturn = await signup(
                                      name.text,
                                      userName.text,
                                      email.text,
                                      country.text,
                                      password.text,
                                      confirmPassword.text);
                                  if (signupReturn is SignupResponseSuccess) {
                                    print('response SignupResponseSuccess');
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString(
                                        'token', signupReturn.accessToken);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PinConfirmScreen()));
                                  }
                                  if (signupReturn is SignUpResponseFail) {
                                    print('response SignupResponseFail');
                                    SignUpResponseFail responseFail =
                                        signupReturn;

                                    String r =
                                        responseFail.modelState.empty == null
                                            ? ''
                                            : responseFail.modelState.empty[0];
                                    String r1 =
                                        responseFail.modelState.modelEmail ==
                                                null
                                            ? ''
                                            : responseFail.modelState
                                                .modelConfirmPassword[0];
                                    String r2 = responseFail.modelState
                                                .modelConfirmPassword ==
                                            null
                                        ? ''
                                        : responseFail
                                            .modelState.modelConfirmPassword[0];

                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        backgroundColor: AppUtilities.appGreen,
                                        content: Text('$r$r1$r2')));
                                  }
                                }
                              } catch (e) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        'something Error Please try again later')));
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
