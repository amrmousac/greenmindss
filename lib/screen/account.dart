import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/models/change_password_error.dart';
import 'package:greenminds/models/profile.dart';
import 'package:greenminds/network/change_password.dart';
import 'package:greenminds/network/profile.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:toast/toast.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Image.asset(
          'assets/images/logorow.png',
          height: 90.h,
        ),
      ),
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          Timer(Duration(microseconds: 500), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AccountScreen()));
          });
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: FutureBuilder<Profile>(
            future: profile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ProfileWidget(profile: snapshot.data);
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Error, Can not fetch data ${snapshot.error}'));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final Profile profile;
  ProfileWidget({
    this.profile,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Account',
              style: TextStyle(
                fontSize: 42.0,
              )),
          infoItem(title: 'Name', value: profile.name),
          infoItem(title: 'email', value: profile.email),
          infoItem(title: 'Country', value: profile.country),
          Container(
              margin: EdgeInsets.only(top: 12.0),
              padding: EdgeInsets.all(4.0),
              height: 90.h,
              width: 700.w,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                ),
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Change password',
                      style: TextStyle(
                        fontSize: 21.0,
                      )),
                  FlatButton(
                    onPressed: () {
                      changePasswordDialog(context);
                    },
                    child: Text('Change'),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget infoItem({String title, String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                fontSize: 21.0,
              )),
          Container(
              padding: EdgeInsets.all(4.0),
              height: 90.h,
              width: 700.w,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                ),
              ]),
              child: Text(value ?? 'unknown')),
        ],
      ),
    );
  }

  void changePasswordDialog(context) {
    TextEditingController oldPassword = TextEditingController();
    TextEditingController newPassword = TextEditingController();
    TextEditingController confirmNewPassword = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Change password"),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                        child: TextFormField(
                            decoration:
                                InputDecoration(hintText: 'your old password'),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: oldPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your old password';
                              }
                              return null;
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                        child: TextFormField(
                            decoration:
                                InputDecoration(hintText: 'your new password'),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: newPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your new password';
                              }
                              return null;
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'confirm new password'),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: confirmNewPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please confirm your new password';
                              }
                              return null;
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Change!'),
                  onPressed: () async {
                    try {
                      if (_formKey.currentState.validate()) {
                        var isSummited = await changePassword(oldPassword.text,
                            newPassword.text, confirmNewPassword.text);
                        if (isSummited is bool) {
                          Toast.show("password changed successfully", context,
                              duration: Toast.LENGTH_LONG,
                              backgroundColor:
                                  AppUtilities.appGreen.withOpacity(0.8),
                              gravity: Toast.CENTER);
                          Navigator.of(context).pop();
                        } else {
                          ChangePasswordError changePasswordError = isSummited;
                          Toast.show(
                              "${'-' + changePasswordError.modelState.empty[0] ?? ''}\n${'-' + changePasswordError.modelState.modelNewPassword[0] ?? ''}\n${'-' + changePasswordError.modelState.modelConfirmPassword[0] ?? ''}",
                              context,
                              duration: Toast.LENGTH_LONG,
                              backgroundColor: Colors.red.withOpacity(0.8),
                              gravity: Toast.CENTER);
                        }
                      }
                    } catch (e) {
                      print(e);
                      Toast.show("error can not reset password", context,
                          duration: Toast.LENGTH_LONG,
                          backgroundColor: Colors.red.withOpacity(0.8),
                          gravity: Toast.CENTER);
                    }
                  },
                )
              ],
            ));
  }
}

/*
 SizedBox(
          height: 500.h,
          width: 700.w,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                child: TextFormField(
                    decoration: InputDecoration(hintText: 'your old password'),
                    keyboardType: TextInputType.phone,
                    // controller: phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your old password';
                      }
                      return null;
                    }),
              ),
            ],
          ),
        )
*/
