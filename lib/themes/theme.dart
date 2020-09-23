import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenminds/themes/app_utilities.dart';

final ThemeData appTheme = ThemeData(
    fontFamily: 'poppins',
    primaryColor: AppUtilities.appGreen,
    accentColor: AppUtilities.appBlue,
    buttonColor: AppUtilities.appGreen,
    scaffoldBackgroundColor: AppUtilities.appBlue,
    cursorColor: AppUtilities.appGreen,
    appBarTheme: AppBarTheme(
        color: AppUtilities.appBlue,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white)),
    textTheme: TextTheme(
      button: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.only(left: 8.0),
      filled: true,
      fillColor: Colors.white30,
      focusColor: AppUtilities.appGreen,
      labelStyle: TextStyle(color: AppUtilities.appGreen),
      hintStyle: TextStyle(color: AppUtilities.appGreen),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppUtilities.appGreen),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppUtilities.appGreen),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppUtilities.appGreen,
      splashColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity);
