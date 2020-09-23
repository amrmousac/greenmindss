import 'dart:convert';

import 'package:greenminds/models/change_password_error.dart';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> changePassword(
  String oldPassword,
  String newPassword,
  String confirmNewPassword,
) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Base.base + 'Account/ChangePassword';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
        body: jsonEncode(<String, String>{
          "OldPassword": oldPassword,
          "NewPassword": newPassword,
          "ConfirmPassword": confirmNewPassword,
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      final parsed = jsonDecode(response.body);
      return ChangePasswordError.fromJson(parsed);
    }
  } catch (e) {
    throw Exception(e);
  }
}
