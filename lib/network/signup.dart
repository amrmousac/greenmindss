import 'dart:convert';
import 'package:greenminds/models/signup_response_fail.dart';
import 'package:greenminds/models/signup_response_success.dart';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;

Future<dynamic> signup(String name, String userName, String email,
    String country, String password, String confirmPassword) async {
  try {
    String url = Base.base + 'Account/Register';

    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "Name": name,
          "UserName": userName,
          "Email": email,
          "Country": country,
          "Password": password,
          "ConfirmPassword": confirmPassword
        }));
    print('response Status ' + response.statusCode.toString());
    print(response.body);
    final parsed = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return SignupResponseSuccess.fromJson(parsed);
    } else if (response.statusCode == 400) {
      return SignUpResponseFail.fromJson(parsed);
    }
    return null;
  } catch (e) {
    throw Exception(e);
  }
}
