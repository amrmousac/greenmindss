import 'dart:async';

import 'package:flutter/material.dart';
import 'package:greenminds/network/confirm_acount.dart';
import 'package:greenminds/screen/sign_in.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinConfirmScreen extends StatefulWidget {
  @override
  _PinConfirmScreenState createState() => _PinConfirmScreenState();
}

class _PinConfirmScreenState extends State<PinConfirmScreen> {
  TextEditingController controller = TextEditingController();
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
              'Please, Enter your Activation code from your email',
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
              child: PinCodeTextField(
                controller: controller,
                length: 4,
                textInputType: TextInputType.number,
                onChanged: (String value) {},
                textStyle: TextStyle(color: Colors.white),
                backgroundColor: Colors.transparent,
                pinTheme: PinTheme(shape: PinCodeFieldShape.box),
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
                  try {
                    print(controller.text);
                    bool isConfirmed = await confirmAcount(controller.text);
                    if (isConfirmed == true) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Account confirmed successfully')));
                      Timer(Duration(seconds: 1), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      });
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Confirmation code not correct')));
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
