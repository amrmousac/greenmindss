import 'dart:convert';

import 'package:greenminds/models/login_response_success.dart';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;

Future<dynamic> login(String user, String pass) async {
  try {
    String url = Base.base + 'Account/Login';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"Username": user, "Password": pass}));
    print('response Status ' + response.statusCode.toString());

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return LoginResponseSuccess.fromJson(parsed);
    }
    return null;
  } catch (e) {
    throw Exception(e);
  }
}
