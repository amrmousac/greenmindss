import 'dart:convert';

import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;

Future<bool> forgetPassword(String email) async {
  try {
    String url = Base.base + 'Account/ForgotPassword';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{"Email": email}));
    print(response.statusCode == 200);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw Exception(e);
  }
}
